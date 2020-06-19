/*
 * Copyright (C) 2020 Canonical, Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

#ifndef MULTIPASS_BASE_VIRTUAL_MACHINE_FACTORY_H
#define MULTIPASS_BASE_VIRTUAL_MACHINE_FACTORY_H

#include <multipass/format.h>
#include <multipass/logging/log.h>
#include <multipass/virtual_machine_factory.h>

#include <daemon/default_vm_image_vault.h>

namespace multipass
{
class BaseVirtualMachineFactory : public VirtualMachineFactory
{
public:
    BaseVirtualMachineFactory(const logging::CString& category) : log_category{category} {};

    FetchType fetch_type() override
    {
        return FetchType::ImageOnly;
    };

    void configure(const std::string& name, YAML::Node& /*meta_config*/, YAML::Node& /*user_config*/) override
    {
        log(logging::Level::trace, log_category, fmt::format("No driver configuration for \"{}\"", name));
    };

    QString get_backend_directory_name() override
    {
        return {};
    };

    VMImageVault::UPtr create_image_vault(std::vector<VMImageHost*> image_hosts, URLDownloader* downloader,
                                          const Path& cache_dir_path, const Path& data_dir_path,
                                          const days& days_to_expire) override
    {
        return std::make_unique<DefaultVMImageVault>(image_hosts, downloader, cache_dir_path, data_dir_path,
                                                     days_to_expire);
    };

protected:
    const logging::CString log_category;
};
} // namespace multipass

#endif // MULTIPASS_BASE_VIRTUAL_MACHINE_FACTORY_H
