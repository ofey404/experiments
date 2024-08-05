import { useEffect } from "react";
import { List, Datagrid, TextField, ReferenceField, Edit, SimpleForm, ReferenceInput, TextInput, Create, SelectInput, Button } from "react-admin";
import { useFormContext } from "react-hook-form";

const postFilters = [
    <TextInput source="q" label="Search" alwaysOn />,
    <ReferenceInput source="userId" label="User" reference="users" />,
];

export const PostList = () => (
    <List filters={postFilters}>
        <Datagrid>
            <ReferenceField source="userId" reference="users" />
            <TextField source="id" />
            <TextField source="title" />
            <TextField source="body" />
        </Datagrid>
    </List>
);

export const PostEdit = () => (
    <Edit>
        <SimpleForm>
            <TextInput source="id" InputProps={{ disabled: true }} />
            <ReferenceInput source="userId" reference="users" />
            {/* <TextInput source="title" /> */}
            <MyTextInput />
            <TextInput source="body" multiline rows={5} />
        </SimpleForm>
    </Edit>
);

const MyTextInput = () => {
    const { setValue, getValues } = useFormContext();

    return (
        <>
            <TextInput source="title" />
            <Button
                onClick={(event) => {
                    event.preventDefault();
                    const currentDate = new Date().toISOString().split('T')[0];
                    const currentTitle = getValues('title');
                    // Set the form as dirty to enable the save button
                    setValue('title', `${currentTitle} - ${currentDate}`, { shouldDirty: true });
                }}
                children={<div>Add Date</div>}
            />
        </>
    );
}

export const PostCreate = () => (
    <Create>
        <SimpleForm>
            <ReferenceInput source="userId" reference="users" />
            <TextInput source="title" />
            <TextInput source="body" multiline rows={5} />
        </SimpleForm>
    </Create>
);