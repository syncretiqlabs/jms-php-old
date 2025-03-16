{include file="../common/head.tpl"}

<section>
    <div class="container">

        <div class="searchBar">
            <div class="input-group mb-3 input-group-lg">
                <input type="text" class="form-control" placeholder="Search Contact Name / Email"
                    aria-label="Recipient's username" aria-describedby="button-addon2">
                <div class="input-group-append mr-3">
                    <button class="btn btn-secondary" type="button" id="button-addon2"><i
                            class="icofont-search-2"></i></button>
                </div>
                <a class="btn btn-md btn-primary mr-1 p-3"><i class="icofont-plus-circle"></i> Add Contacts</a>
            </div>
        </div>

        <h1 class="mb-1 pb-1">John Smith</h1>
        <div class="mb-2">
            <a href="{$host_url}/index.php/contact/contact"><i class="icofont-rounded-left"></i>&nbsp; Back to listing</a>
        </div>
        <div class="boxStyle p-4">
            <div class="row">
                <div class="col-3 leftMenu">
                    <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                        <a class="nav-link active" id="v-pills-home-tab" data-toggle="pill" href="#v-pills-home"
                            role="tab" aria-controls="v-pills-home" aria-selected="true">Personal Information</a>
                        <a class="nav-link" id="v-pills-documents-tab" data-toggle="pill" href="#v-pills-documents"
                            role="tab" aria-controls="v-pills-documents" aria-selected="false">Documents</a>
                    </div>
                </div>
                <div class="col-9 rightContent">
                    <div class="tab-content" id="v-pills-tabContent">
                        <div class="tab-pane fade show active" id="v-pills-home" role="tabpanel"
                            aria-labelledby="v-pills-home-tab">
                            <div class="border-bottom py-2 row">
                                <div class="col-sm-8">
                                    <h4>Personal Information</h4>
                                </div>
                                <div class="col-sm-4 text-right">
                                    <a href="{$host_url}/index.php/contact/contact_edit/index/{$contact.Id}"><i class="icofont-ui-edit"></i>&nbsp; Edit</a>
                                </div>
                            </div>


                            <form class="mt-2">
                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label text-right">Contact Name</label>
                                    <div class="col-sm-9">
                                        <div class="pt-2">
                                            <h5>{if $contact.ContactType == 'Organisation'}{$contact.CompanyName}{else}{$contact.FirstName} {$contact.LastName}{/if}</h5>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col-3 text-right"">
                                        <label for="" class=" pr-2">Status</label>
                                    </div>
                                    <div class="form-group col-9">
                                        <div class="btn-group btn-group-toggle" data-toggle="buttons">
                                            <label class="btn btn-tertiary active">
                                            <input type="radio" name="options" id="option1" {if $contact.IsActive == 1}checked{/if}> Active
                                            </label>
                                            <label class="btn btn-tertiary">
                                                <input type="radio" name="options" id="option2" {if $contact.IsActive == 0}checked{/if}> Inactive
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label text-right">Contact Type</label>
                                    <div class="col-sm-9">
                                                <div class="pt-2"><strong>{if isset($contact.ContactType)}{$contact.ContactType}{/if}</strong></div>
                                        </select>
                                    </div>
                                </div>
                                {if $contact.ContactType == 'Organisation'}
                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label text-right">Company Name</label>
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
                                            <label for="" class="col-sm-6 col-form-label text-right">Category</label>
                                            <div class="col-sm-6 pl-2">
                                                <div class="pt-2"><strong>{if isset($contact.ContactCategory)}{$contact.ContactCategory}{/if}</strong></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label text-right">Address</label>
                                    <div class="col-sm-9">
                                                <div class="pt-2"><strong>{if isset($contact.Address1)}{$contact.Address1}{/if}</strong></div>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="col-6">
                                        <div class="form-group row">
                                            <label for="" class="col-sm-6 col-form-label text-right">Suburb</label>
                                            <div class="col-sm-6 pl-2">
                                                <div class="pt-2"><strong>{if isset($contact.Suburb)}{$contact.Suburb}{/if}</strong></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="form-group row">
                                            <label for="" class="col-sm-6 col-form-label text-right">City</label>
                                            <div class="col-sm-6 ">
                                                <div class="pt-2"><strong>{if isset($contact.City)}{$contact.City}{/if}</strong></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label text-right">Email</label>
                                    <div class="col-sm-9">
                                                <div class="pt-2"><strong>{if isset($contact.Email)}{$contact.Email}{/if}</strong></div>
                                        </select>
                                    </div>
                                </div>


                                <div class="form-row">
                                    <div class="col-6">
                                        <div class="form-group row">
                                            <label for="" class="col-sm-6 col-form-label text-right">Mobile</label>
                                            <div class="col-sm-6 ">
                                                <div class="pt-2"><strong>{if isset($contact.Mobile)}{$contact.Mobile}{/if}</strong></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="form-group row">
                                            <label for="" class="col-sm-6 col-form-label text-right">Phone</label>
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
                            <h2>Documents</h2>
                            <p>Documents</p>
                            <table class="table table-hover table-responsive-sm">
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
</section>

{include file="../common/footer.tpl"}