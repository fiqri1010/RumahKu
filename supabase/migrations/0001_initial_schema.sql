-- RumahKu — Initial Unified Asset Schema & RLS Policies for Supabase (PostgreSQL)
-- Supports Offline-First Delta/Outbox Sync (UUID v7 IDs, UTC timestamps, soft-delete tombstones)
-- Designed for Supabase Free Tier (Zero-Cost / Rp 0, No Credit Card)

-- ============================================================================
-- 1. CORE TABLES
-- ============================================================================

CREATE TABLE IF NOT EXISTS public.households (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  invite_code TEXT UNIQUE NOT NULL,
  currency_code TEXT NOT NULL DEFAULT 'IDR',
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  deleted_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS public.household_members (
  id TEXT PRIMARY KEY,
  household_id TEXT NOT NULL REFERENCES public.households(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  role TEXT NOT NULL DEFAULT 'member' CHECK (role IN ('owner', 'member')),
  display_name TEXT NOT NULL DEFAULT '',
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  deleted_at TIMESTAMPTZ,
  UNIQUE (household_id, user_id)
);

CREATE TABLE IF NOT EXISTS public.locations (
  id TEXT PRIMARY KEY,
  household_id TEXT NOT NULL REFERENCES public.households(id) ON DELETE CASCADE,
  parent_id TEXT REFERENCES public.locations(id) ON DELETE SET NULL,
  name TEXT NOT NULL,
  kind TEXT NOT NULL DEFAULT 'room' CHECK (
    kind IN (
      'property',
      'room',
      'furniture',
      'bookshelf',
      'safe_folder',
      'container',
      'moving_box',
      'vehicle_compartment'
    )
  ),
  qr_code TEXT,
  notes TEXT,
  sort_order INTEGER NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  deleted_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS public.items (
  id TEXT PRIMARY KEY,
  household_id TEXT NOT NULL REFERENCES public.households(id) ON DELETE CASCADE,
  location_id TEXT REFERENCES public.locations(id) ON DELETE SET NULL,
  container_item_id TEXT REFERENCES public.items(id) ON DELETE SET NULL,
  name TEXT NOT NULL,
  category TEXT NOT NULL DEFAULT 'Umum',
  asset_type TEXT NOT NULL DEFAULT 'general' CHECK (
    asset_type IN (
      'general',
      'electronics',
      'furniture',
      'appliance',
      'tool',
      'hobby',
      'vehicle',
      'book',
      'document'
    )
  ),
  quantity INTEGER NOT NULL DEFAULT 1 CHECK (quantity >= 0),
  brand TEXT,
  model_number TEXT,
  serial_number TEXT,
  barcode TEXT,
  qr_code TEXT,
  purchase_price DOUBLE PRECISION,
  purchase_date TIMESTAMPTZ,
  purchase_store TEXT,
  estimated_value DOUBLE PRECISION,
  warranty_expires_at TIMESTAMPTZ,
  condition TEXT NOT NULL DEFAULT 'good' CHECK (
    condition IN ('excellent', 'good', 'fair', 'broken')
  ),
  usage_mode TEXT NOT NULL DEFAULT 'daily_status' CHECK (
    usage_mode IN (
      'daily_status',
      'count_tracked',
      'vehicle_odometer',
      'book_reading',
      'archive_doc'
    )
  ),
  utility_status TEXT NOT NULL DEFAULT 'frequent' CHECK (
    utility_status IN (
      'essential',
      'frequent',
      'occasional',
      'idle',
      'for_sale',
      'disposed'
    )
  ),
  utility_rating INTEGER CHECK (utility_rating IS NULL OR (utility_rating BETWEEN 1 AND 5)),
  usage_count INTEGER NOT NULL DEFAULT 0 CHECK (usage_count >= 0),
  last_used_at TIMESTAMPTZ,
  notes TEXT,
  custom_fields_json JSONB NOT NULL DEFAULT '{}'::jsonb,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  deleted_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS public.item_attachments (
  id TEXT PRIMARY KEY,
  household_id TEXT NOT NULL REFERENCES public.households(id) ON DELETE CASCADE,
  item_id TEXT NOT NULL REFERENCES public.items(id) ON DELETE CASCADE,
  kind TEXT NOT NULL DEFAULT 'photo' CHECK (
    kind IN (
      'photo',
      'cover',
      'receipt',
      'warranty',
      'manual',
      'doc_scan_pdf',
      'stnk',
      'bpkb',
      'insurance'
    )
  ),
  local_path TEXT,
  remote_path TEXT,
  mime_type TEXT NOT NULL DEFAULT 'image/jpeg',
  file_size_bytes INTEGER,
  page_order INTEGER NOT NULL DEFAULT 0,
  is_sensitive BOOLEAN NOT NULL DEFAULT FALSE,
  upload_status TEXT NOT NULL DEFAULT 'pending' CHECK (
    upload_status IN ('pending', 'synced', 'failed')
  ),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  deleted_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS public.asset_loans (
  id TEXT PRIMARY KEY,
  household_id TEXT NOT NULL REFERENCES public.households(id) ON DELETE CASCADE,
  item_id TEXT NOT NULL REFERENCES public.items(id) ON DELETE CASCADE,
  borrower_name TEXT NOT NULL,
  borrower_contact TEXT,
  borrowed_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  due_return_at TIMESTAMPTZ,
  returned_at TIMESTAMPTZ,
  notes TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  deleted_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS public.usage_logs (
  id TEXT PRIMARY KEY,
  household_id TEXT NOT NULL REFERENCES public.households(id) ON DELETE CASCADE,
  item_id TEXT NOT NULL REFERENCES public.items(id) ON DELETE CASCADE,
  used_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  notes TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  deleted_at TIMESTAMPTZ
);

-- ============================================================================
-- 2. SPECIALIZED DOMAIN EXTENSIONS (1-to-1 WITH items.id)
-- ============================================================================

CREATE TABLE IF NOT EXISTS public.books (
  item_id TEXT PRIMARY KEY REFERENCES public.items(id) ON DELETE CASCADE,
  household_id TEXT NOT NULL REFERENCES public.households(id) ON DELETE CASCADE,
  isbn_10 TEXT,
  isbn_13 TEXT,
  subtitle TEXT,
  authors_json JSONB NOT NULL DEFAULT '[]'::jsonb,
  publisher TEXT,
  published_year INTEGER,
  page_count INTEGER,
  language TEXT DEFAULT 'id',
  genre_tags_json JSONB NOT NULL DEFAULT '[]'::jsonb,
  series_name TEXT,
  series_number DOUBLE PRECISION,
  edition TEXT,
  book_format TEXT NOT NULL DEFAULT 'paperback' CHECK (
    book_format IN ('paperback', 'hardcover', 'comic', 'magazine', 'textbook', 'religious', 'ebook')
  ),
  reading_status TEXT NOT NULL DEFAULT 'unread' CHECK (
    reading_status IN ('unread', 'reading', 'finished', 'abandoned', 'reference')
  ),
  current_page INTEGER NOT NULL DEFAULT 0,
  personal_rating INTEGER CHECK (personal_rating IS NULL OR (personal_rating BETWEEN 1 AND 5)),
  started_reading_at TIMESTAMPTZ,
  finished_reading_at TIMESTAMPTZ,
  synopsis TEXT,
  review_notes TEXT,
  metadata_source TEXT NOT NULL DEFAULT 'manual' CHECK (
    metadata_source IN ('openlibrary', 'google_books', 'gemini_ai', 'manual')
  ),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  deleted_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS public.documents (
  item_id TEXT PRIMARY KEY REFERENCES public.items(id) ON DELETE CASCADE,
  household_id TEXT NOT NULL REFERENCES public.households(id) ON DELETE CASCADE,
  related_item_id TEXT REFERENCES public.items(id) ON DELETE SET NULL,
  doc_category TEXT NOT NULL DEFAULT 'other' CHECK (
    doc_category IN (
      'identity',
      'property',
      'vehicle',
      'education_work',
      'finance_insurance',
      'medical',
      'other'
    )
  ),
  doc_subtype TEXT,
  document_number TEXT,
  owner_member_name TEXT,
  issuer TEXT,
  issued_at TIMESTAMPTZ,
  expires_at TIMESTAMPTZ,
  is_original BOOLEAN NOT NULL DEFAULT TRUE,
  copy_count INTEGER NOT NULL DEFAULT 1,
  physical_folder_label TEXT,
  is_vault_locked BOOLEAN NOT NULL DEFAULT TRUE,
  ocr_extracted_text TEXT,
  tags_json JSONB NOT NULL DEFAULT '[]'::jsonb,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  deleted_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS public.vehicles (
  item_id TEXT PRIMARY KEY REFERENCES public.items(id) ON DELETE CASCADE,
  household_id TEXT NOT NULL REFERENCES public.households(id) ON DELETE CASCADE,
  vehicle_kind TEXT NOT NULL DEFAULT 'motorcycle' CHECK (
    vehicle_kind IN ('car', 'motorcycle', 'bicycle', 'other')
  ),
  plate_number TEXT,
  vin_rangka TEXT,
  engine_number TEXT,
  manufacture_year INTEGER,
  fuel_type TEXT,
  current_odometer_km INTEGER NOT NULL DEFAULT 0,
  stnk_annual_due_at TIMESTAMPTZ,
  stnk_5yr_due_at TIMESTAMPTZ,
  insurance_due_at TIMESTAMPTZ,
  insurance_provider TEXT,
  bpkb_number TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  deleted_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS public.vehicle_service_logs (
  id TEXT PRIMARY KEY,
  household_id TEXT NOT NULL REFERENCES public.households(id) ON DELETE CASCADE,
  vehicle_id TEXT NOT NULL REFERENCES public.vehicles(item_id) ON DELETE CASCADE,
  service_date TIMESTAMPTZ NOT NULL,
  odometer_km INTEGER,
  service_type TEXT NOT NULL,
  workshop_name TEXT,
  total_cost DOUBLE PRECISION NOT NULL DEFAULT 0,
  next_due_date TIMESTAMPTZ,
  next_due_odometer_km INTEGER,
  notes TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  deleted_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS public.vehicle_fuel_logs (
  id TEXT PRIMARY KEY,
  household_id TEXT NOT NULL REFERENCES public.households(id) ON DELETE CASCADE,
  vehicle_id TEXT NOT NULL REFERENCES public.vehicles(item_id) ON DELETE CASCADE,
  filled_at TIMESTAMPTZ NOT NULL,
  odometer_km INTEGER NOT NULL,
  liters DOUBLE PRECISION NOT NULL,
  price_per_liter DOUBLE PRECISION,
  total_cost DOUBLE PRECISION NOT NULL,
  is_full_tank BOOLEAN NOT NULL DEFAULT TRUE,
  computed_km_per_liter DOUBLE PRECISION,
  notes TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  deleted_at TIMESTAMPTZ
);

-- ============================================================================
-- 3. MOVING PROJECTS & REMINDERS
-- ============================================================================

CREATE TABLE IF NOT EXISTS public.moving_projects (
  id TEXT PRIMARY KEY,
  household_id TEXT NOT NULL REFERENCES public.households(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  origin_address TEXT,
  destination_address TEXT,
  target_move_date TIMESTAMPTZ,
  status TEXT NOT NULL DEFAULT 'planning' CHECK (
    status IN ('planning', 'packing', 'in_transit', 'completed')
  ),
  notes TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  deleted_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS public.moving_boxes (
  id TEXT PRIMARY KEY,
  household_id TEXT NOT NULL REFERENCES public.households(id) ON DELETE CASCADE,
  project_id TEXT NOT NULL REFERENCES public.moving_projects(id) ON DELETE CASCADE,
  location_id TEXT NOT NULL REFERENCES public.locations(id) ON DELETE CASCADE,
  box_code TEXT NOT NULL,
  label_qr TEXT NOT NULL,
  destination_room TEXT,
  status TEXT NOT NULL DEFAULT 'packing' CHECK (
    status IN ('packing', 'ready', 'in_transit', 'arrived', 'unpacked')
  ),
  is_fragile BOOLEAN NOT NULL DEFAULT FALSE,
  priority TEXT NOT NULL DEFAULT 'medium' CHECK (priority IN ('high', 'medium', 'low')),
  weight_kg DOUBLE PRECISION,
  notes TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  deleted_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS public.reminders (
  id TEXT PRIMARY KEY,
  household_id TEXT NOT NULL REFERENCES public.households(id) ON DELETE CASCADE,
  item_id TEXT REFERENCES public.items(id) ON DELETE CASCADE,
  kind TEXT NOT NULL CHECK (
    kind IN (
      'warranty',
      'stnk_annual',
      'stnk_5yr',
      'insurance',
      'service_date',
      'service_km',
      'doc_expiry',
      'loan_due',
      'declutter_audit'
    )
  ),
  title TEXT NOT NULL,
  due_at TIMESTAMPTZ,
  due_odometer_km INTEGER,
  remind_days_before INTEGER NOT NULL DEFAULT 14,
  is_completed BOOLEAN NOT NULL DEFAULT FALSE,
  completed_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  deleted_at TIMESTAMPTZ
);

-- ============================================================================
-- 4. INDEXES FOR DELTA SYNC & FAST LOOKUPS
-- ============================================================================

CREATE INDEX IF NOT EXISTS idx_locations_household_updated ON public.locations (household_id, updated_at);
CREATE INDEX IF NOT EXISTS idx_locations_parent ON public.locations (parent_id);
CREATE INDEX IF NOT EXISTS idx_items_household_updated ON public.items (household_id, updated_at);
CREATE INDEX IF NOT EXISTS idx_items_location ON public.items (location_id);
CREATE INDEX IF NOT EXISTS idx_items_asset_type ON public.items (household_id, asset_type);
CREATE INDEX IF NOT EXISTS idx_items_qr ON public.items (qr_code);
CREATE INDEX IF NOT EXISTS idx_items_barcode ON public.items (barcode);
CREATE INDEX IF NOT EXISTS idx_attachments_item ON public.item_attachments (item_id);
CREATE INDEX IF NOT EXISTS idx_books_isbn13 ON public.books (isbn_13);
CREATE INDEX IF NOT EXISTS idx_documents_category ON public.documents (household_id, doc_category);
CREATE INDEX IF NOT EXISTS idx_reminders_due ON public.reminders (household_id, is_completed, due_at);

-- ============================================================================
-- 5. HELPER FUNCTIONS & ROW LEVEL SECURITY (RLS)
-- ============================================================================

CREATE OR REPLACE FUNCTION public.is_household_member(target_household_id TEXT)
RETURNS BOOLEAN
LANGUAGE SQL
SECURITY DEFINER
STABLE
AS $$
  SELECT EXISTS (
    SELECT 1
    FROM public.household_members hm
    WHERE hm.household_id = target_household_id
      AND hm.user_id = auth.uid()
      AND hm.deleted_at IS NULL
  );
$$;

-- Lightweight read-only health check for free GitHub Actions keep-alive cron
CREATE TABLE IF NOT EXISTS public.health_pings (
  id INTEGER PRIMARY KEY DEFAULT 1,
  last_ping_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
INSERT INTO public.health_pings (id) VALUES (1) ON CONFLICT (id) DO NOTHING;

ALTER TABLE public.health_pings ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "health_pings_public_read" ON public.health_pings;
CREATE POLICY "health_pings_public_read"
  ON public.health_pings FOR SELECT
  TO anon, authenticated
  USING (TRUE);

-- RPC: Join household using invite code
CREATE OR REPLACE FUNCTION public.join_household_by_code(
  p_invite_code TEXT,
  p_member_id TEXT,
  p_display_name TEXT
)
RETURNS TEXT
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_household_id TEXT;
BEGIN
  SELECT id INTO v_household_id
  FROM public.households
  WHERE invite_code = UPPER(TRIM(p_invite_code))
    AND deleted_at IS NULL
  LIMIT 1;

  IF v_household_id IS NULL THEN
    RAISE EXCEPTION 'Kode undangan rumah tidak ditemukan';
  END IF;

  INSERT INTO public.household_members (id, household_id, user_id, role, display_name)
  VALUES (p_member_id, v_household_id, auth.uid(), 'member', COALESCE(NULLIF(p_display_name, ''), 'Anggota'))
  ON CONFLICT (household_id, user_id)
  DO UPDATE SET deleted_at = NULL, updated_at = NOW(), display_name = EXCLUDED.display_name;

  RETURN v_household_id;
END;
$$;

-- Enable RLS across all household-scoped tables
ALTER TABLE public.households ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.household_members ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.locations ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.items ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.item_attachments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.asset_loans ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.usage_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.books ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.documents ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.vehicles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.vehicle_service_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.vehicle_fuel_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.moving_projects ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.moving_boxes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.reminders ENABLE ROW LEVEL SECURITY;

-- Households policies
DROP POLICY IF EXISTS "households_select" ON public.households;
CREATE POLICY "households_select" ON public.households
  FOR SELECT TO authenticated USING (public.is_household_member(id));

DROP POLICY IF EXISTS "households_insert" ON public.households;
CREATE POLICY "households_insert" ON public.households
  FOR INSERT TO authenticated WITH CHECK (TRUE);

DROP POLICY IF EXISTS "households_update" ON public.households;
CREATE POLICY "households_update" ON public.households
  FOR UPDATE TO authenticated USING (public.is_household_member(id));

-- Household members policies
DROP POLICY IF EXISTS "members_select" ON public.household_members;
CREATE POLICY "members_select" ON public.household_members
  FOR SELECT TO authenticated USING (public.is_household_member(household_id) OR user_id = auth.uid());

DROP POLICY IF EXISTS "members_insert_self" ON public.household_members;
CREATE POLICY "members_insert_self" ON public.household_members
  FOR INSERT TO authenticated WITH CHECK (user_id = auth.uid());

DROP POLICY IF EXISTS "members_update" ON public.household_members;
CREATE POLICY "members_update" ON public.household_members
  FOR UPDATE TO authenticated USING (public.is_household_member(household_id));

-- Macro-style uniform policies for all household_id domain tables
DO $$
DECLARE
  tbl TEXT;
BEGIN
  FOREACH tbl IN ARRAY ARRAY[
    'locations',
    'items',
    'item_attachments',
    'asset_loans',
    'usage_logs',
    'books',
    'documents',
    'vehicles',
    'vehicle_service_logs',
    'vehicle_fuel_logs',
    'moving_projects',
    'moving_boxes',
    'reminders'
  ] LOOP
    EXECUTE format('DROP POLICY IF EXISTS "%s_member_all" ON public.%I;', tbl, tbl);
    EXECUTE format(
      'CREATE POLICY "%s_member_all" ON public.%I FOR ALL TO authenticated ' ||
      'USING (public.is_household_member(household_id)) ' ||
      'WITH CHECK (public.is_household_member(household_id));',
      tbl, tbl
    );
  END LOOP;
END $$;

-- ============================================================================
-- 6. PRIVATE STORAGE BUCKETS (1 GB FREE TIER)
-- ============================================================================

INSERT INTO storage.buckets (id, name, public)
VALUES
  ('item-media', 'item-media', FALSE),
  ('sensitive-docs', 'sensitive-docs', FALSE)
ON CONFLICT (id) DO NOTHING;

-- Folder convention: <household_id>/<item_id>/<attachment_id>.<ext>
DROP POLICY IF EXISTS "rumahku_storage_member_access" ON storage.objects;
CREATE POLICY "rumahku_storage_member_access"
  ON storage.objects FOR ALL
  TO authenticated
  USING (
    bucket_id IN ('item-media', 'sensitive-docs')
    AND public.is_household_member((storage.foldername(name))[1])
  )
  WITH CHECK (
    bucket_id IN ('item-media', 'sensitive-docs')
    AND public.is_household_member((storage.foldername(name))[1])
  );
