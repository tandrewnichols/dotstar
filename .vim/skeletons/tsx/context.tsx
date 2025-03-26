'use client';

import React, { useState, useContext, PropsWithChildren, useMemo } from 'react';

export interface ${1:`!v join(split(g:Abolish.titlecase(expand('%:t:r')), ' '), '')`}Options {
  ${2}
}

export const defaultOptions: ${1:`!v join(split(g:Abolish.titlecase(expand('%:t:r')), ' '), '')`}Options = {
  ${3}
};

export const ${1:`!v join(split(g:Abolish.titlecase(expand('%:t:r')), ' '), '')`} = React.createContext<${1:`!v join(split(g:Abolish.titlecase(expand('%:t:r')), ' '), '')`}Options>(defaultOptions);

export const use${1:`!v join(split(g:Abolish.titlecase(expand('%:t:r')), ' '), '')`} = () => {
  const context = useContext<${1:`!v join(split(g:Abolish.titlecase(expand('%:t:r')), ' '), '')`}Options>(${1:`!v join(split(g:Abolish.titlecase(expand('%:t:r')), ' '), '')`});

  if (!context) {
    throw new Error('use${1:`!v join(split(g:Abolish.titlecase(expand('%:t:r')), ' '), '')`} must be used within a ${1:`!v join(split(g:Abolish.titlecase(expand('%:t:r')), ' '), '')`}Provider');
  }

  return context;
};

interface Props extends PropsWithChildren {
  ${4}
}

export default function ${1:`!v join(split(g:Abolish.titlecase(expand('%:t:r')), ' '), '')`}Provider({ $5, children }: Props) {
  ${6}

  const value = useMemo(() => ({
    ${5}
  }), []);

  return (
    <${1:`!v join(split(g:Abolish.titlecase(expand('%:t:r')), ' '), '')`}.Provider value={value}>
      {children}
    </${1:`!v join(split(g:Abolish.titlecase(expand('%:t:r')), ' '), '')`}.Provider>
  );
}
