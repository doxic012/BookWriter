require 'test_helper'

class PdfExportSettingsControllerTest < ActionController::TestCase
=begin

   setup do
    @pdf_export_setting = pdf_export_settings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pdf_export_settings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pdf_export_setting" do
    assert_difference('PdfExportSetting.count') do
      post :create, pdf_export_setting: { foot: @pdf_export_setting.foot, head: @pdf_export_setting.head, insertFoot: @pdf_export_setting.insertFoot, insertHead: @pdf_export_setting.insertHead, marginBottom: @pdf_export_setting.marginBottom, marginLeft: @pdf_export_setting.marginLeft, marginRight: @pdf_export_setting.marginRight, marginTop: @pdf_export_setting.marginTop, tableOfContent: @pdf_export_setting.tableOfContent }
    end

    assert_redirected_to pdf_export_setting_path(assigns(:pdf_export_setting))
  end

  test "should show pdf_export_setting" do
    get :show, id: @pdf_export_setting
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pdf_export_setting
    assert_response :success
  end

  test "should update pdf_export_setting" do
    put :update, id: @pdf_export_setting, pdf_export_setting: { foot: @pdf_export_setting.foot, head: @pdf_export_setting.head, insertFoot: @pdf_export_setting.insertFoot, insertHead: @pdf_export_setting.insertHead, marginBottom: @pdf_export_setting.marginBottom, marginLeft: @pdf_export_setting.marginLeft, marginRight: @pdf_export_setting.marginRight, marginTop: @pdf_export_setting.marginTop, tableOfContent: @pdf_export_setting.tableOfContent }
    assert_redirected_to pdf_export_setting_path(assigns(:pdf_export_setting))
  end

  test "should destroy pdf_export_setting" do
    assert_difference('PdfExportSetting.count', -1) do
      delete :destroy, id: @pdf_export_setting
    end

    assert_redirected_to pdf_export_settings_path
  end
=end
end
