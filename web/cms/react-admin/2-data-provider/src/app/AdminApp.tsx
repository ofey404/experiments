'use client'

import type { ReactNode } from "react";
import { Layout as RALayout, CheckForApplicationUpdate } from "react-admin";
import {
    Admin,
    Resource,
    ListGuesser,
    EditGuesser,
    ShowGuesser,
} from "react-admin";
import { useDataProvider } from "./dataProvider";
// import { dataProvider } from "./dataProvider";

export const AdminApp = () => {
    const dataProvider = useDataProvider()

    return <Admin layout={Layout} dataProvider={dataProvider}>
        <Resource name="users" list={ListGuesser} edit={EditGuesser} />
    </Admin>
}


export const Layout = ({ children }: { children: ReactNode }) => (
    <RALayout>
        {children}
        <CheckForApplicationUpdate />
    </RALayout>
);