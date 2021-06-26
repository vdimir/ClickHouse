#pragma once

namespace DB
{

/// Actions performed if common type can't be infered
enum class OnNoCommonType
{
    /// Throw exception
    Throw,
    /// Return DataTypeNothing
    Nothing,
    /// Return nullptr
    Null,
};

}
