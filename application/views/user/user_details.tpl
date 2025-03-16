{include file="../common/head.tpl"}

<section>
    <div class="container">
        {if $logged_in_user.UserRole == 'superadmin' || $logged_in_user.UserRole == 'admin'}
            <div class="searchBar">
                <div class="row">
                    <div class="col">
                        <h1 class="mb-1 pb-1">
        
             {if $logged_in_user.UserRole == 'superadmin' || $logged_in_user.UserRole == 'admin'}
                <a href="{$host_url}/index.php/user/user">Users</a>
            {/if}
             | {$user.FirstName} {$user.LastName}</h1>
                    </div>
                    <div class="md-auto pr-1">
                        <div class="input-group mb-3 input-group-lg">
                            <a href="{$host_url}/index.php/user/user_detail" class="btn btn-md btn-primary mr-1 p-3"><i class="icofont-plus-circle"></i> Add User</a>
                        </div>
                    </div>
                </div>
            </div>
        {/if}

        
        {* <div class="mb-2">
            {if $logged_in_user.UserRole == 'superadmin' || $logged_in_user.UserRole == 'admin'}
                <a href="{$host_url}/index.php/user/user"><i class="icofont-rounded-left"></i>&nbsp; Back to User listing</a>
            {/if}
        </div> *}
        <div class="boxStyle p-4">
            <div class="row">
                <div class="col-12 col-md-3 leftMenu">
                    <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                        <a class="nav-link active" id="v-pills-home-tab" data-toggle="pill" href="#v-pills-home"
                            role="tab" aria-controls="v-pills-home" aria-selected="true">Personal Information</a>
                        <a class="nav-link extra_tabs" id="v-pills-password-tab" data-toggle="pill"
                                href="#v-pills-password" role="tab" aria-controls="v-pills-password"
                                aria-selected="false">Change Password</a>
                        <a class="extra_tabs nav-link" id="v-pills-documents-tab" data-toggle="pill" href="#v-pills-documents"
                            role="tab" aria-controls="v-pills-documents" aria-selected="false">Documents</a>
                    </div>
                </div>
                <div class="col-12 col-md-9 rightContent">
                    <div class="tab-content" id="v-pills-tabContent">
                        <div class="tab-pane fade show active" id="v-pills-home" role="tabpanel"
                            aria-labelledby="v-pills-home-tab">
                            <div class="border-bottom py-2 row">
                                <div class="col-sm-8">
                                    <h4>Personal Information</h4>
                                </div>
                                <div class="col-sm-4">
                                    <a href="{$host_url}/index.php/user/user_detail/index/{$user.UserId}"><i class="icofont-ui-edit"></i>&nbsp; Edit</a>
                                </div>
                            </div>


                            <form class="mt-2">
                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label">User Name</label>
                                    <div class="col-sm-9">
                                        <div class="pt-2">
                                            <h5>{$user.UserName}</h5>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label">Name</label>
                                    <div class="col-sm-9">
                                        <div class="pt-2">
                                            <h5>{$user.FirstName} {$user.LastName}</h5>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label">User Type</label>
                                    <div class="col-sm-9">
                                                <div class="pt-2"><strong>{$user.UserType}</strong></div>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label">User Role</label>
                                    <div class="col-sm-9">
                                                <div class="pt-2"><strong>{$user.UserRole}</strong></div>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label">Address</label>
                                    <div class="col-sm-9">
                                                <div class="pt-2"><strong>{if isset($user.Address)}{$user.Address}, {$user.Suburb}, {$user.City}{/if}</strong></div>
                                        </select>
                                    </div>
                                </div>

                                {* <div class="form-row">
                                    <div class="col-6">
                                        <div class="form-group row">
                                            <label for="" class="col-sm-6 col-form-label">Suburb</label>
                                            <div class="col-sm-6 pl-2">
                                                <div class="pt-2"><strong>{if isset($user.Suburb)}{$user.Suburb}{/if}</strong></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="form-group row">
                                            <label for="" class="col-sm-6 col-form-label">City</label>
                                            <div class="col-sm-6 ">
                                                <div class="pt-2"><strong>{if isset($user.City)}{$user.City}{/if}</strong></div>
                                            </div>
                                        </div>
                                    </div>
                                </div> *}

                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label">Email</label>
                                    <div class="col-sm-9">
                                                <div class="pt-2"><strong>{if isset($user.Email)}{$user.Email}{/if}</strong></div>
                                        </select>
                                    </div>
                                </div>


                                <div class="form-row">
                                    <div class="col-6">
                                        <div class="form-group row">
                                            <label for="" class="col-sm-6 col-form-label">Mobile</label>
                                            <div class="col-sm-6 ">
                                                <div class="pt-2"><strong>{if isset($user.Mobile)}{$user.Mobile}{/if}</strong></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="form-group row">
                                            <label for="" class="col-sm-6 col-form-label">Phone</label>
                                            <div class="col-sm-6 pl-2">
                                                <div class="pt-2"><strong>{if isset($user.Phone)}{$user.Phone}{/if}</strong></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>


                        </div>
                        <div class="tab-pane fade" id="v-pills-password" role="tabpanel" aria-labelledby="v-pills-password-tab">
                            <div class="py-2 row">
                                <div class="col">
                                    <h4>Change Password</h4>
                                    <form class="add_user" id="add_user" enctype="multipart/form-data" method="POST" action="{$host_url}/index.php/user/user_detail/save_password">
                                            <input type="hidden" name="id" class="id" value="{if isset($user.UserId)}{$user.UserId}{/if}">
                                            <div class="form-group row">
                                                <label for="" class="col-sm-3 col-form-label">Password</label>
                                                <div class="col-sm-3">
                                                    <input type="password" class="form-control" id="password" name="password"
                                                        value="">
                                                </div>
                                                <label for="" class="col-sm-3 col-form-label">Confirm Password</label>
                                                <div class="col-sm-3">
                                                    <input type="password" class="form-control" id="password_confirm" name="password"
                                                        value="">
                                                </div>
                                            </div>

                                            <div class="col-sm-3">
                                                <small id="passwordHelp" class="password_error text-danger" style="display: none;">The passwords doesnt match.</small>
                                            </div>

                                            <div class="form-group row">
                                                <label for="" class="col-sm-3 col-form-label"></label>
                                                <div class="col-sm-9">
                                                    <button type="submit" name="button" value="submit"
                                                        class="btn btn-lg btn-primary" id="submit">Save</button>
                                                </div>
                                            </div>
                                    </form>
                                </div>
                            </div>
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
                                                    <div class="col"><input type="hidden" name="id"
                                                            value="{if isset($user.UserId)}{$user.UserId}{/if}">
                                                        <input type="hidden" id="ajax_url"
                                                            value="{$host_url}/index.php/ajax/user_ajax/file_upload">
                                                        <input type="file" class="form-control-file" name="document"
                                                            value="file_upload" id="exampleFormControlFile1">
                                                    </div>
                                                    <div class="col">
                                                        <button type="submit" name="button" id="button_file"
                                                            value="submit_document" class="btn btn-primary">
                                                            <i class="icofont-upload-alt"></i> Upload</button>
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
                                        {if (!isset($user_documents))}
                                            <tr class="no_dcoument_message">
                                                <td>No document have been uploaded.</td>
                                            </tr>
                                        {else}
                                            {foreach from=$user_documents key=key item=value}
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