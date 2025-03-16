{include file='../common/head.tpl'}

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
                <a href="{$host_url}/index.php/user/user">Users</a> | 
            {if isset($user_detail.UserId)} {$user_detail.FirstName} {$user_detail.LastName} {else}
                Add New User
            {/if}
        </h1>
        <div class="boxStyle p-4">
            <div class="row">
                <input type="hidden" id="type" value="{if isset($type)}{$type}{else}user{/if}">
                <div class="col-12 col-md-3 leftMenu">
                    <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                        <a class="nav-link active" id="v-pills-home-tab" data-toggle="pill" href="#v-pills-home"
                            role="tab" aria-controls="v-pills-home" aria-selected="true">Personal Information</a>
                        <a class="nav-link extra_tabs" id="v-pills-documents-tab" data-toggle="pill"
                            href="#v-pills-documents" role="tab" aria-controls="v-pills-documents"
                            aria-selected="false">Documents</a>
                        {if isset($user_detail.UserId)}
                            <a class="nav-link extra_tabs" id="v-pills-password-tab" data-toggle="pill"
                                href="#v-pills-password" role="tab" aria-controls="v-pills-password"
                                aria-selected="false">Change Password</a>
                        {/if}
                    </div>
                </div>
                <div class="col-12 col-md-9 rightContent">
                    <div class="tab-content" id="v-pills-tabContent">
                        <div class="tab-pane fade show active" id="v-pills-home" role="tabpanel"
                            aria-labelledby="v-pills-home-tab">
                            <h4 class="pb-4">Personal Information</h4>
                            <form class="add_user" id="add_user" enctype="multipart/form-data" method="POST">
                                <input type="hidden" name="submit_option" class="submit_option" value="">

                                 <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label ">UserName</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control" id="user_name" name="user_name"
                                            value="{if isset($user_detail.UserName)}{$user_detail.UserName}{/if}">
                                        <input type="hidden" class="form-control" name="id"
                                            value="{if isset($user_detail.UserId)}{$user_detail.UserId}{else}new{/if}">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label ">Email</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control" id="email" name="email"
                                            value="{if isset($user_detail.Email)}{$user_detail.Email}{/if}">
                                    </div>
                                </div>
                                {if !isset($user_detail.UserId)}
                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label ">Password</label>
                                    <div class="col-sm-9">
                                        <input type="password" class="form-control" id="password" name="password"
                                            value="">
                                            </div>
                                </div>
                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label ">Confirm Password</label>
                                    <div class="col-sm-9">
                                        <input type="password" class="form-control" id="password" name="password"
                                            value="">
                                    </div>
                                </div>
                                 {/if}
                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label ">First Name</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control" id="first_name" name="first_name"
                                            value="{if isset($user_detail.FirstName)}{$user_detail.FirstName}{/if}">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label ">Last Name</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control" id="last_name" name="last_name"
                                            value="{if isset($user_detail.LastName)}{$user_detail.LastName}{/if}">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label ">Address1</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control" id="address" name="address"
                                            value="{if isset($user_detail.Address)}{$user_detail.Address}{/if}">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label ">Suburb</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control" id="suburb" name="suburb"
                                            value="{if isset($user_detail.Suburb)}{$user_detail.Suburb}{/if}">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label ">City</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control" id="city" name="city"
                                            value="{if isset($user_detail.City)}{$user_detail.City}{/if}">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label ">DOB</label>
                                    <div class="col-sm-9">
                                        <input type="date" class="form-control" id="datepicker" name="dob"
                                            value="{if isset($user_detail.DOB)}{$user_detail.DOB}{/if}">
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="col-6">
                                        <div class="form-group row">
                                            <label for="" class="col-sm-6 col-form-label ">User Type</label>
                                            <div class="col-sm-6 pl-2">
                                            {if $logged_in_user.UserRole == 'member'}
                                                <input type="text" class="form-control"  name="employee_type" readonly="readonly"
                                                    value="{if isset($user_detail.UserType)}{$user_detail.UserType}{/if}">
                                            {else}
                                                <select id="inputState employee_type" class="form-control"
                                                    name="employee_type">
                                                    <option value='customer'
                                                        {if isset($user_detail.UserType) && $user_detail.UserType == 'customer'}selected{/if}>
                                                        customer</option>
                                                    <option value='contractor'
                                                        {if isset($user_detail.UserType) && $user_detail.UserType == 'contractor'}selected{/if}>
                                                        contractor</option>
                                                    <option value='supplier'
                                                        {if isset($user_detail.UserType) && $user_detail.UserType == 'supplier'}selected{/if}>
                                                        supplier</option>
                                                    <option value='employee'
                                                        {if (isset($user_detail.UserType) && $user_detail.UserType == 'employee') || !isset($user_detail.UserType) || $user_detail.UserType == ''}selected{/if}>
                                                        employee</option>
                                                </select>
                                            {/if}
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="form-group row">
                                            <label for="" class="col-sm-6 col-form-label ">User Role</label>
                                            <div class="col-sm-6  pl-2">
                                            {if $logged_in_user.UserRole == 'member'}
                                                <input type="text" class="form-control"  name="employee_role" readonly="readonly"
                                                    value="{if isset($user_detail.UserRole)}{$user_detail.UserRole}{/if}">
                                            {else}
                                                <select id="inputState employee_role" class="form-control"
                                                    name="employee_role">
                                                    <option
                                                        {if !isset($user_detail.UserRole) || $user_detail.UserRole == ''}selected{/if}
                                                        disabled value="default">Select...</option>
                                                    <option value='superadmin'
                                                        {if isset($user_detail.UserRole) && $user_detail.UserRole == 'superadmin'}selected{/if}>
                                                        superadmin</option>
                                                    <option value='admin'
                                                        {if isset($user_detail.UserRole) && $user_detail.UserRole == 'admin'}selected{/if}>
                                                        admin</option>
                                                    <option value='supervisor'
                                                        {if isset($user_detail.UserRole) && $user_detail.UserRole == 'supervisor'}selected{/if}>
                                                        supervisor</option>
                                                    <option value='member'
                                                        {if isset($user_detail.UserRole) && $user_detail.UserRole == 'member'}selected{/if}>
                                                        member</option>
                                                </select>
                                            {/if}
                                            </div>
                                        </div>
                                    </div>
                                </div>


                                <div class="form-row">
                                    <div class="col-6">
                                        <div class="form-group row">
                                            <label for="" class="col-sm-6 col-form-label ">Mobile</label>
                                            <div class="col-sm-6  pl-2">
                                                <input type="text" class="form-control" id="mobile" name="mobile"
                                                    value="{if isset($user_detail.Mobile)}{$user_detail.Mobile}{/if}">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="form-group row">
                                            <label for="" class="col-sm-6 col-form-label ">Phone</label>
                                            <div class="col-sm-6 pl-2">
                                                <input type="text" class="form-control" id="phone" name="phone"
                                                    value="{if isset($user_detail.Phone)}{$user_detail.Phone}{/if}">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label ">Status</label>
                                    <div class="col-sm-9">
                                    <select id="inputState status" class="form-control" name="status">
                                        <option {if !isset($user_detail.Status) || $user_detail.Status == '1'}selected{/if} value=1>Active</option>
                                        <option value=0 {if isset($user_detail.Status) && $user_detail.Status == '0'}selected{/if}> In-Active</option>
                                    </select>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="" class="col-sm-3 col-form-label "></label>
                                    <div class="col-sm-9">
                                        <button type="submit" name="button" value="submit"
                                            class="btn btn-lg btn-primary" id="submit">Save</button>
                                        <button  action="action" onclick="window.history.go(-1); return false;" class="btn btn-lg btn-secondary"
                                            id="cancel">Cancel</button>
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
                                                    <div class="col"><input type="hidden" name="id"
                                                            value="{if isset($user_detail.UserId)}{$user_detail.UserId}{/if}">
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
                                            <th scope="col">Document Name <a href="#" class="caret"><i
                                                        class="icofont-upload-alt"></i></a></th>
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
                                                    <td>{$value.AddedOn}<input type="hidden" class="document_id"
                                                            value="{$value.Id}"></td>
                                                    <td>{$value.Name}</td>
                                                    <td>
                                                        <a href="{$host_url}/{$value.Path}" target="_blank" class="btn btn-sm"
                                                            data-toggle="tooltip" data-placement="bottom" title="View"><i
                                                                class="active icofont-eye-alt"></i></a>
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
                        {if isset($user_detail.UserId)}
                        <div class="tab-pane fade" id="v-pills-password" role="tabpanel" aria-labelledby="v-pills-password-tab">
                            <div class="py-2 row">
                                <div class="col">
                                    <h4>Change Password</h4>
                                    <form class="add_user" id="add_user" enctype="multipart/form-data" method="POST" action="{$host_url}/index.php/user/user_detail/save_password">
                                            <input type="hidden" name="id" class="id" value="{if isset($user_detail.UserId)}{$user_detail.UserId}{/if}">
                                            <div class="user form-group row">
                                                <label for="" class="col-sm-3 col-form-label ">Password</label>
                                                <div class="col-sm-3">
                                                    <input type="password" class="form-control" id="password" name="password"
                                                        value="">
                                                </div>
                                                <label for="" class="col-sm-3 col-form-label ">Confirm Password</label>
                                                <div class="col-sm-3">
                                                    <input type="password" class="form-control" id="password_confirm" name="password"
                                                        value="">
                                                </div>
                                            </div>

                                            <div class="col-sm-3">
                                                <small id="passwordHelp" class="password_error text-danger" style="display: none;">The passwords doesnt match.</small>
                                            </div>

                                            <div class="form-group row">
                                                <label for="" class="col-sm-3 col-form-label "></label>
                                                <div class="col-sm-9">
                                                    <button type="submit" name="button" value="submit"
                                                        class="btn btn-lg btn-primary" id="submit">Save</button>
                                                </div>
                                            </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        {/if}
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
</section>

{include file='../common/footer.tpl'}