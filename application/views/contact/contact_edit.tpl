{include file="../common/head.tpl"}

<section>
    <div class="container">

        <!-- <div class="searchBar">
        <div class="input-group mb-3 input-group-lg">
                <input type="text" class="form-control" placeholder="Search Contact Name / Email" aria-label="Recipient's username" aria-describedby="button-addon2">
                <div class="input-group-append mr-3">
                    <button class="btn btn-secondary" type="button" id="button-addon2"><i class="icofont-search-2"></i></button>
                </div>
                <a class="btn btn-md btn-primary mr-1 p-3"><i class="icofont-plus-circle"></i> Add Contacts</a>
                </div>
        </div> -->
        <h1 class="mb-1 pb-3">
        <a href="{$host_url}/index.php/contact/contact">Contacts</a> | 
        {if !isset($contact)}Add New Contact
        {else}Edit Contact
        {/if}
        </h1>
        <div class="boxStyle p-4">
            <div class="row">
                <div class="col-12 col-md-3 leftMenu">
                    <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                        <a class="nav-link active" id="v-pills-home-tab" data-toggle="pill" href="#v-pills-home" role="tab" aria-controls="v-pills-home" aria-selected="true">{if isset($contact) && $contact.ContactType == 'People'}People {elseif !isset($contact) || $contact.ContactType == 'Organisation'} Organisation {/if}Information</a>
                        <a class="extra_tabs nav-link" id="v-pills-documents-tab" data-toggle="pill" href="#v-pills-documents" role="tab" aria-controls="v-pills-documents" aria-selected="false">Documents</a>
                    </div>
                    <hr>
                </div>
                <div class="col-12 col-md-9 rightContent">
                    <div class="tab-content" id="v-pills-tabContent">
                        <div class="tab-pane fade show active" id="v-pills-home" role="tabpanel" aria-labelledby="v-pills-home-tab">
                            <h4 class="pb-4">{if isset($contact) && $contact.ContactType == 'People'}People {elseif !isset($contact) || $contact.ContactType == 'Organisation'} Organisation {/if}Information</h4>
                            <form method="post" class="add_contact">
                                <input type="hidden" name="id" id="id" value="{if isset($contact.Id)}{$contact.Id}{else}new{/if}" >
                                <input type="hidden" name="type" id="type" value="{if isset($type)}{$type}{/if}" >
                                <div class="form-row">

                                    <div class="form-group col-3 "">
                                    </div>
                                    <div class=" form-group col-9">
                                        <div class="btn-group btn-group-toggle" data-toggle="buttons">
                                            <label class="btn btn-tertiary active">
                                                <input type="radio" name="contact_type" id="option1" value="People" {if isset($contact) && $contact.ContactType=='People'}checked{/if}> <i class="icofont-user-alt-7"></i> People
                                            </label>
                                            <label class="btn btn-tertiary">
                                                <input type="radio" name="contact_type" id="option2" value="Organisation" {if !isset($contact) || (isset($contact) && $contact.ContactType=='Organisation')}checked{/if}> <i class="icofont-building-alt"></i> Organisation
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label ">Category</label>
                                    <div class="col-sm-9">
                                        <select id="inputState" name="contact_category" id="contact_category" class="required form-control">
                                            <option {if !isset($contact.ContactCategory)} selected {/if} disabled value="default">Select...</option>
                                            <option value="Customer" {if !isset($contact.ContactCategory) || (isset($contact.ContactCategory) && $contact.ContactCategory == 'Customer')} selected {/if}>Customer</option>
                                            <option value="Supplier" {if isset($contact.ContactCategory) && $contact.ContactCategory == 'Supplier'} selected {/if}>Supplier</option>
                                            <option value="Sub-contractor" {if isset($contact.ContactCategory) && $contact.ContactCategory == 'Sub-contractor'} selected {/if}>Sub-contractor</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="company form-group row">
                                    <label for="" class="col-sm-3 col-form-label ">Company Name</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control company_name" id="company_name" name="company_name" value="{if isset($contact.CompanyName)}{$contact.CompanyName}{/if}">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label ">Email</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control company_name" id="email" name="email" value="{if isset($contact.Email)}{$contact.Email}{/if}">
                                    </div>
                                </div>
                                <div class="user form-group row">
                                    <label for="" class="col-sm-3 col-form-label ">First Name</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control" id="first_name" name="first_name" value="{if isset($contact.FirstName)}{$contact.FirstName}{/if}">
                                    </div>
                                </div>

                                <div class=" user form-group row">
                                        <label for="" class="col-sm-3 col-form-label ">Last Name</label>
                                        <div class="col-sm-9">
                                            <input type="text" class="form-control" id="last_name" name="last_name" value="{if isset($contact.LastName)}{$contact.LastName}{/if}">
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label for="" class="col-sm-3 col-form-label ">Address1</label>
                                        <div class="col-sm-9">
                                            <input type="text" class="form-control" id="address" name="address" value="{if isset($contact.Address1)}{$contact.Address1}{/if}">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="" class="col-sm-3 col-form-label ">Suburb</label>
                                        <div class="col-sm-9">
                                            <input type="text" class="form-control" id="suburb" name="suburb" value="{if isset($contact.Suburb)}{$contact.Suburb}{/if}">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="" class="col-sm-3 col-form-label ">City</label>
                                        <div class="col-sm-9">
                                            <input type="text" class="form-control" id="city" name="city" value="{if isset($contact.City)}{$contact.City}{/if}">
                                        </div>
                                    </div>

                                    <div class="form-row">
                                        <div class="col-6">
                                            <div class="form-group row">
                                                <label for="" class="col-sm-6 col-form-label ">Phone</label>
                                                <div class="col-sm-6 pl-2">
                                                    <input type="text" class="form-control" id="phone" name="phone" value="{if isset($contact.Phone)}{$contact.Phone}{/if}">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-6">
                                            <div class="form-group row">
                                                <label for="" class="col-sm-6 col-form-label ">Mobile</label>
                                                <div class="col-sm-6 ">
                                                    <input type="text" class="form-control" id="mobile" name="mobile" value="{if isset($contact.Mobile)}{$contact.Mobile}{/if}">
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label ">Status</label>
                                    <div class="col-sm-9">
                                        <select id="inputState" name="contact_status" id="contact_status" class="required form-control">
                                            <option value="1" {if !isset($contact.IsActive) || (isset($contact.IsActive) && $contact.IsActive == '1')} selected {/if}>Active</option>
                                            <option value="0" {if isset($contact.IsActive) && $contact.IsActive == '0'} selected {/if}>In-Active</option>
                                        </select>
                                    </div>
                                </div>

                                    <div class="form-group row">
                                        <label for="" class="col-sm-3 col-form-label "></label>
                                        <div class="col-sm-9">
                                            <button type="submit" name="button" value="submit_general" class="btn btn-lg btn-primary">Save</button>
                                            <button class="btn btn-lg btn-secondary" action="action"
    onclick="window.history.go(-1); return false;">Cancel</button>
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
                                                    <td>
                                                        {$value.AddedOn}
                                                        <input type="hidden" class="document_id" value="{$value.Id}" >    
                                                    </td>
                                                    <td>{$value.Name}</td>
                                                    <td>
                                                        <a href="{$host_url}/{$value.Path}" target="_blank" class="btn btn-sm" data-toggle="tooltip" data-placement="bottom" title="View"><i class="active icofont-eye-alt"></i></a>
                                                        <a href="#" class="document_delete btn btn-sm" data-toggle="tooltip"
                                                            data-placement="bottom" title="Delete"><i
                                                                class="active icofont-ui-delete"></i></a>
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