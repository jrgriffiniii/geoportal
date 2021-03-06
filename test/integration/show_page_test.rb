require "test_helper"

class ShowPageTest < Capybara::Rails::TestCase

  def setup
  end

  def teardown
    ran_without_js_errors
  end

  def test_indiana_shapefile_show
    skip("Doc is no longer in Solr. / EWL 07/18/18")
    visit "/catalog/4a9b467d-a344-4557-9f14-db166636d4b2"
    assert page.has_content?("Bicycle and Pedestrian Trails and Paths: Bloomington, Indiana, 2016")

    # Type
    click_link 'Web services'

    # WMS Web Service
    assert page.has_content?("Web Mapping Service (WMS)")
    assert page.has_selector?("#wms_webservice")

    # Esri Web Service
    assert page.has_no_content?("ArcGIS Dynamic Map Layer")
    assert page.has_no_selector?("#dynamic_map_layer_webservice")

    # Download
    assert page.has_content?("Download Shapefile")

    # Provenance
    assert page.has_content?("Indiana")
  end

  def test_wisconsin_geodatabase_show
    skip("Doc is no longer in Solr. / EWL 07/18/18")
    visit "/catalog/656ed665-63fc-45d9-96ab-465a07488f91"
    assert page.has_content?("Hydrography (1:24,000), Wisconsin 2015")

    # Type
    assert page.has_no_link?("Web services")

    # ISO Metadata
    assert page.has_link?("Metadata")

    # IIIF Image
    assert page.has_no_content?("iiif")

    # Download
    assert page.has_content?("Download Geodatabase")

    # Provenance
    assert page.has_content?("Wisconsin")
  end

  def test_minnesota_tiff_show
    visit "/catalog/71f15b25-64cd-40cc-8f0c-64529293398c"
    assert page.has_content?("Railroad commissioners' map of Minnesota")

    # Type
    assert page.has_link?("Web services")
    click_link 'Web services'

    # WMS Web Service
    assert page.has_no_content?("Web Mapping Service (WMS)")
    assert page.has_no_selector?("#wms_webservice")

    # Esri Web Service
    assert page.has_no_content?("ArcGIS Dynamic Map Layer")
    assert page.has_no_selector?("#dynamic_map_layer_webservice")

    # IIIF
    assert page.has_content?("International Image Interoperability Framework (IIIF)")

    # Type
    click_button 'Close'

    # ISO Metadata
    assert page.has_no_link?("Metadata")

    # IIIF Image
    assert page.has_selector?("div[data-protocol='Iiif']")

    # Downloads
    assert page.has_content?("Downloads")
    assert page.has_link?("Original Tiff")
    assert page.has_link?("Original JPG")

    # Provenance
    assert page.has_content?("Minnesota")
  end

  def test_minnesota_shapefile_show
    visit "/catalog/b98a7b39-830a-48ca-84c2-06332aaebbb8"
    assert page.has_content?("Twin Cities Land Use Map from the Twin Cities Metropolitan Planning Commission, 1958")

    # Type
    click_link 'Web services'

    # WMS Web Service
    assert page.has_no_content?("Web Mapping Service (WMS)")
    assert page.has_no_selector?("#wms_webservice")

    # Esri Web Service
    assert page.has_content?("ArcGIS Dynamic Map Layer")
    assert page.has_selector?("#dynamic_map_layer_webservice")

    # Type
    click_button 'Close'

    # ISO Metadata
    assert page.has_link?("Metadata")

    # IIIF Image
    assert page.has_no_selector?("div[data-protocol='Iiif']")

    # Download
    assert page.has_content?("Downloads")
    assert page.has_link?("Original Shapefile")

    # Provenance
    assert page.has_link?("Minnesota")
  end

  def test_iowa_map_show
    visit "/catalog/f1b57f24-d474-4493-90e1-d3c25f39b65b"
    assert page.has_content?("An Illustrated Historical Atlas of Des Moines County, Iowa, 1873")

    # Type
    click_link 'Web services'

    # WMS Web Service
    assert page.has_no_content?("Web Mapping Service (WMS)")
    assert page.has_no_selector?("#wms_webservice")

    # Esri Web Service
    assert page.has_content?("ArcGIS Dynamic Map Layer")
    assert page.has_selector?("#dynamic_map_layer_webservice")

    # ISO Metadata
    assert page.has_no_link?("Metadata")

    # IIIF Image
    assert page.has_no_content?("iiif")

    # Download
    assert page.has_no_content?("Download Tiff")

    # Provenance
    assert page.has_content?("Iowa")
  end

  def test_maryland_esri_slow_show
    skip("Doc is no longer in Solr. / EWL 07/18/18")
    visit "/catalog/7333122beb68414e9e7744f2dd986578_0"
    assert page.has_content?("Housing Market Typology: Baltimore, Maryland")

    # Type
    click_link 'Web services'

    # WMS Web Service
    assert page.has_no_content?("Web Mapping Service (WMS)")
    assert page.has_no_selector?("#wms_webservice")

    # Esri Feature Layer
    assert page.has_content?("ArcGIS Feature Layer")
    assert page.has_selector?("#feature_layer_webservice")

    # ISO Metadata
    assert page.has_no_link?("Metadata")

    # IIIF Image
    assert page.has_no_content?("iiif")

    # Download
    assert page.has_content?("Download Shapefile")

    # Provenance
    assert page.has_content?("Maryland")
  end

  def test_iowa_esri_imageserver_show
    skip("Doc is no longer in Solr. / EWL 03/28/18")
    visit "/catalog/e1e49389-801d-4bce-b400-4e20b08aec94"
    assert page.has_content?("Aerial Imagery: Iowa")

    # Type
    click_link 'Web services'

    # WMS Web Service
    assert page.has_no_content?("Web Mapping Service (WMS)")
    assert page.has_no_selector?("#wms_webservice")

    # Esri Image Map Layer
    assert page.has_content?("ArcGIS Image Map Layer")
    assert page.has_selector?("#image_map_layer_webservice")

    # ISO Metadata
    assert page.has_no_link?("Metadata")

    # IIIF Image
    assert page.has_no_content?("iiif")

    # Download
    assert page.has_no_content?("Download Shapefile")

    # Provenance
    assert page.has_content?("Iowa")
  end

  def test_relations_related_records
    visit "/catalog/88cc9b19-3294-4da9-9edd-775c81fb1c59"
    assert page.has_content?("Wabash River Topographic Maps: Indiana, 1929")

    # Metadata
    # ISO Metadata
    assert page.has_link?("Metadata")

    assert page.has_link?("Web services")

    # Data Relations
    assert page.has_content?("Relations")
    assert page.has_content?("Related Records")

    # Browse Relations - Missing?
    # click_link("Browse all 25 records...")
    # within("span.page_entries") do
    #   assert page.has_content?("25")
    # end
  end

  def test_relations_child_record
    visit "/catalog/02999877-0ee9-4cc0-b67f-f2f48107f517"

    # ISO Metadata
    assert page.has_link?("Metadata")

    # Download
    assert page.has_content?("Downloads")
    assert page.has_link?("Original GeoTIFF")

    # Data Relations
    assert page.has_content?("Relations")
    assert page.has_content?("Parent Record")
  end

  def test_open_index_map_record
    skip("Doc is no longer in Solr. / EWL 02/26/19")
    visit "/catalog/cornell-ny-aerial-photos-1960s"
    assert page.has_selector?("#map")
    assert page.has_selector?("[data-protocol=IndexMap]")
  end

  def test_fullscreen_map_toggle
    visit "/catalog/87adb12a-30b5-4bc3-866c-97adcd7e3d2e"
    assert page.has_selector?(".leaflet-control-fullscreen-button")
    click_on(class: 'leaflet-control-fullscreen-button')
  end

  def test_sidebar_map_basemap
    visit "/catalog/f9eb8493-32ab-4ede-8330-9286846eee0d"
    assert page.has_selector?("[data-basemap=positron]")
  end
end
