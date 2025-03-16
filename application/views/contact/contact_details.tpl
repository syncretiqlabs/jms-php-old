{include file="../common/head.tpl"}

<section>
    <div class="container">

        <div class="searchBar">
            <div class="row">
            <div class="col">
                <h1 class="mb-1">
                <a href="{$host_url}/index.php/contact/contact">Contacts</a> | 
               {if $contact.ContactType == 'Organisation'}{$contact.CompanyName}{else}{$contact.FirstName} {$contact.LastName}{/if}</h1>
            </div>
            <div class="md-auto pr-1">
                <div class="input-group mb-3 input-group-lg">
                    <a href="{$host_url}/index.php/contact/contact_edit" class="btn btn-md btn-primary mr-1 p-3"><i class="icofont-plus-circle"></i> Add Contacts</a>
                </div>
            </div>
            </div>
            
        </div>

        
        <div class="boxStyle p-4">
            <div class="row">
                <div class="col-12 col-md-3 leftMenu">
                    <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                        <a class="nav-link active" id="v-pills-home-tab" data-toggle="pill" href="#v-pills-home"
                            role="tab" aria-controls="v-pills-home" aria-selected="true">{if $contact.ContactType == 'Organisation'}Organisation {else} Personal {/if} Information</a>
                        <a class="nav-link" id="v-pills-documents-tab" data-toggle="pill" href="#v-pills-documents"
                            role="tab" aria-controls="v-pills-documents" aria-selected="false">Documents</a>
                    </div>
                </div>
                <div class="col-12 col-md-9 rightContent">
                    <div class="tab-content" id="v-pills-tabContent">
                        <div class="tab-pane fade show active" id="v-pills-home" role="tabpanel"
                            aria-labelledby="v-pills-home-tab">
                            <div class="border-bottom py-2 row">
                                <div class="col-sm-8">
                                    <h4>{if $contact.ContactType == 'Organisation'}Organisation {else} Personal {/if} Information</h4>
                                </div>
                                <div class="col-sm-4 ">
                                    <a href="{$host_url}/index.php/jobs/add?cid={$contact.Id}"><i class="icofont-ui-edit"></i>&nbsp; Add Job</a>&nbsp;&nbsp;
                                    <a href="{$host_url}/index.php/contact/contact_edit/index/{$contact.Id}"><i class="icofont-ui-edit"></i>&nbsp; Edit</a>
                                </div>
                            </div>


                            <form class="mt-2">
                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label ">Contact Name</label>
                                    <div class="col-sm-9">
                                        <div class="pt-2">
                                            <h5>
                                                {if $contact.ContactType == 'Organisation'}
                                                    {$contact.CompanyName}
                                                {else}
                                                    {$contact.FirstName} {$contact.LastName}
                                                {/if}
                                            </h5>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label ">Status</label>
                                    <div class="col-sm-9">
                                        <div class="pt-2"><strong>{if $contact.IsActive == 0}Inactive{else}Active{/if}</strong></div>
                                    </div>
                                    
                                </div>
                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label ">Contact Type</label>
                                    <div class="col-sm-9">
                                        <div class="pt-2"><strong>{if isset($contact.ContactType)}{$contact.ContactType}{/if}</strong></div>
                                    </div>
                                </div>
                                {if $contact.ContactType == 'Organisation'}
                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label ">Company Name</label>
                                    <div class="col-sm-9">
                                        <div class="pt-2">
                                            <h5>{$contact.CompanyName}</h5>
                                        </div>
                                    </div>
                                </div>
                                {/if}
                                <div class="form-row">
                                    <div class="col-6">
                                        <div class="form-group row">
                                            <label for="" class="col-sm-6 col-form-label ">Category</label>
                                            <div class="col-sm-6 pl-2">
                                                <div class="pt-2"><strong>{if isset($contact.ContactCategory)}{$contact.ContactCategory}{/if}</strong></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label ">Address</label>
                                    <div class="col-sm-9">
                                            <div class="pt-2"><strong>{if isset($contact.Address1)}{$contact.Address1}{/if}, {if isset($contact.Suburb)}{$contact.Suburb}{/if}, {if isset($contact.City)}{$contact.City}{/if}</strong></div>
                                        </select>
                                    </div>
                                </div>

                                {* <div class="form-row">
                                    <div class="col-6">
                                        <div class="form-group row">
                                            <label for="" class="col-sm-6 col-form-label ">Suburb</label>
                                            <div class="col-sm-6 pl-2">
                                                <div class="pt-2"><strong>{if isset($contact.Suburb)}{$contact.Suburb}{/if}</strong></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="form-group row">
                                            <label for="" class="col-sm-6 col-form-label ">City</label>
                                            <div class="col-sm-6 ">
                                                <div class="pt-2"><strong>{if isset($contact.City)}{$contact.City}{/if}</strong></div>
                                            </div>
                                        </div>
                                    </div>
                                </div> *}

                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label ">Email</label>
                                    <div class="col-sm-9">
                                                <div class="pt-2"><strong>{if isset($contact.Email)}{$contact.Email}{/if}</strong></div>
                                        </select>
                                    </div>
                                </div>


                                <div class="form-row">
                                    <div class="col-6">
                                        <div class="form-group row">
                                            <label for="" class="col-sm-6 col-form-label ">Mobile</label>
                                            <div class="col-sm-6 ">
                                                <div class="pt-2"><strong>{if isset($contact.Mobile)}{$contact.Mobile}{/if}</strong></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="form-group row">
                                            <label for="" class="col-sm-6 col-form-label ">Phone</label>
                                            <div class="col-sm-6 pl-2">
                                                <div class="pt-2"><strong>{if isset($contact.Phone)}{$contact.Phone}{/if}</strong></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>


                        </div>
                        <div class="tab-pane fade" id="v-pills-documents" role="tabpanel"
                            aria-labelledby="v-pills-documents-tab">
                            <div class="py-2 row">
                                    <div class="col">
                                        <h4>Documents</h4>
                                        <div class="mr-auto">
                                            <div class="form-group">
                                                <h6>Upload Docuents</h6>
                                                <form method='post' class="file_upload_form" enctype="multipart/form-data">
                                                    <div class="row">
                                                        <div class="col">
                                                            <input type="hidden" name="id" value="{$contact.Id}">
                                                            <input type="hidden" id="ajax_url" value="{$host_url}/index.php/ajax/contact_ajax/file_upload">
                                                            <input type="file" class="form-control-file" name="document" value="file_upload" id="exampleFormControlFile1">
                                                        </div>
                                                        <div class="col">
                                                            <button type="submit" name="button" id="button_file" value="submit_document" class="btn btn-sm btn-primary mt-1"><i class="fas fa-arrow-alt-from-bottom"></i> Upload</button>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                <table class="table table-hover table-responsive-sm" id="documentlist">
                                    <thead class="thead-dark">
                                        <tr>
                                            <th scope="col">Date Uploaded</th>
                                            <th scope="col">Document Name <a href="#" class="caret"><i class="icofont-upload-alt"></i></a></th>
                                            <th scope="col">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {if (!isset($contact_documents))}
                                            <tr class="no_dcoument_message">
                                                <td>No document have been uploaded.</td>
                                            </tr>
                                        {else}
                                            {foreach from=$contact_documents key=key item=value}
                                                <tr>
                                                    <td>{$value.AddedOn}</td>
                                                    <td>{$value.Name}</td>
                                                    <td>
                                                        <a href="{$host_url}/{$value.Path}" target="_blank" class="btn btn-sm" data-toggle="tooltip" data-placement="bottom" title="View"><i class="active icofont-eye-alt"></i></a>
                                                    </td>
                                                </tr>
                                            {/foreach}
                                        {/if}
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

{include file="../common/footer.tpl"}