// in src/users.tsx
import { List, Datagrid, TextField, EmailField, UrlField } from "react-admin";
import MyUrlField from "./MyUrlField";

export const UserList = () => (
    <List>
        <Datagrid>
            <TextField source="id" />
            <TextField source="name" />
            {/* <TextField source="username" /> */}
            <EmailField source="email" />
            {/* <TextField source="address.street" /> */}
            <TextField source="phone" />
            {/* 2. Tweak the UI with guesser */}
            {/* <UrlField source="website" /> */}
            <MyUrlField source="website" />
            <TextField source="company.name" />
        </Datagrid>
    </List>
);