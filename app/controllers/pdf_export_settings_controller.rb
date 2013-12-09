class PdfExportSettingsController < ApplicationController
  # PUT /pdf_export_settings/1
  # PUT /pdf_export_settings/1.json
  def update

    @pdf_export_setting = PdfExportSetting.find(params[:id])

    currentBook = Book.find(params[:book_id])

    respond_to do |format|
      #chunks have to be saved manually, cause we dont want to save the id-strings from
      #params, but instead the found chunk-objects for those ids.

      #save chunks:
      saveSuccess = true

      saveSuccess = @pdf_export_setting.update_attribute(:chunks, Chunk.find_all_by_id(params[:pdf_export_setting][:chunks]))

      #save the rest:
      saveSuccess = @pdf_export_setting.update_attributes(params[:pdf_export_setting].except(:chunks))

      if saveSuccess
        format.html {
          #redirect to book (closed modal), if commit-button was "close & save"
          if (params[:commit] == I18n.t('views.close_save'))
            redirect_to currentBook

            return
          end

          redirect_to print_book_path(currentBook, :format => 'pdf'), notice: 'Pdf export setting was successfully updated.'
        }
        format.json { head :no_content }
      #else
      #  #error while saving
      #  #format.json { render json: @pdf_export_setting.errors, status: :unprocessable_entity }
      #end
    end
  end

=begin
  # GET /pdf_export_settings
  # GET /pdf_export_settings.json
  def index
    @pdf_export_settings = PdfExportSetting.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pdf_export_settings }
    end
  end

  # GET /pdf_export_settings/1
  # GET /pdf_export_settings/1.json
  def show
    @pdf_export_setting = PdfExportSetting.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pdf_export_setting }
    end
  end

  # GET /pdf_export_settings/new
  # GET /pdf_export_settings/new.json
  def new
    @pdf_export_setting = PdfExportSetting.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pdf_export_setting }
    end
  end

  # GET /pdf_export_settings/1/edit
  def edit
    @pdf_export_setting = PdfExportSetting.find(params[:id])
  end

  # POST /pdf_export_settings
  # POST /pdf_export_settings.json
  def create
    @pdf_export_setting = PdfExportSetting.new(params[:pdf_export_setting])

    respond_to do |format|
      if @pdf_export_setting.save
        format.html { redirect_to @pdf_export_setting, notice: 'Pdf export setting was successfully created.' }
        format.json { render json: @pdf_export_setting, status: :created, location: @pdf_export_setting }
      else
        format.html { render action: "new" }
        format.json { render json: @pdf_export_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pdf_export_settings/1
  # PUT /pdf_export_settings/1.json
  def update
    @pdf_export_setting = PdfExportSetting.find(params[:id])

    respond_to do |format|
      if @pdf_export_setting.update_attributes(params[:pdf_export_setting])
        format.html { redirect_to @pdf_export_setting, notice: 'Pdf export setting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pdf_export_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pdf_export_settings/1
  # DELETE /pdf_export_settings/1.json
  def destroy
    @pdf_export_setting = PdfExportSetting.find(params[:id])
    @pdf_export_setting.destroy

    respond_to do |format|
      format.html { redirect_to pdf_export_settings_url }
      format.json { head :no_content }
    end
  end
=end

end
