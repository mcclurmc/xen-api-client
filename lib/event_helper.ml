(*
 * Copyright (C) 2006-2009 Citrix Systems Inc.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published
 * by the Free Software Foundation; version 2.1 only. with the special
 * exception on linking described in file LICENSE.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *)

type event_record = 
    | Session of          [`Session ] API.Ref.t * API.session_t option
    | Task of             [`task ] API.Ref.t * API.task_t option
    | Event of            [`Event] API.Ref.t * API.event_t option
    | VM of               [`VM] API.Ref.t * API.vM_t option
    | VM_metrics of       [`VM_metrics] API.Ref.t * API.vM_metrics_t option
    | VM_guest_metrics of [`VM_guest_metrics] API.Ref.t * API.vM_guest_metrics_t option
    | Host of             [`host] API.Ref.t * API.host_t option
    | Host_metrics of     [`host_metrics] API.Ref.t * API.host_metrics_t option
    | Host_cpu of         [`host_cpu] API.Ref.t * API.host_cpu_t option
    | Network of          [`network] API.Ref.t * API.network_t option
    | VIF of              [`VIF] API.Ref.t * API.vIF_t option 
    | VIF_metrics of      [`VIF_metrics] API.Ref.t * API.vIF_metrics_t option
    | PIF of              [`PIF] API.Ref.t * API.pIF_t option
    | PIF_metrics of      [`PIF_metrics] API.Ref.t * API.pIF_metrics_t option
    | SR of               [`SR] API.Ref.t * API.sR_t option
    | VDI of              [`VDI] API.Ref.t * API.vDI_t option
    | VBD of              [`VBD] API.Ref.t * API.vBD_t option
    | VBD_metrics of      [`VBD_metrics] API.Ref.t * API.vBD_metrics_t option
    | PBD of              [`PBD] API.Ref.t * API.pBD_t option
    | Crashdump of        [`Crashdump] API.Ref.t * API.crashdump_t option
    | VTPM of             [`VTPM] API.Ref.t *  API.vTPM_t option
    | Console of          [`Console] API.Ref.t * API.console_t option
    | User of             [`User] API.Ref.t * API.user_t option
    | Pool of             [`pool] API.Ref.t *  API.pool_t option
    | Message of          [`message] API.Ref.t * API.message_t option
    | Secret of           [`secret] API.Ref.t * API.secret_t option
    | VMPP of             [`VMPP] API.Ref.t * API.vMPP_t option

let maybe f x =
    match x with 
		| Some x -> Some (f x)
		| None -> None
			
let record_of_event ev =
	let rpc = ev.Event_types.snapshot in
    match ev.Event_types.ty with
		| "session" ->          Session (API.Ref.of_string ev.Event_types.reference, maybe (API.session_t_of_rpc) rpc)
		| "task" ->             Task (API.Ref.of_string ev.Event_types.reference, maybe (API.task_t_of_rpc) rpc)
		| "event" ->            Event (API.Ref.of_string ev.Event_types.reference, maybe (API.event_t_of_rpc) rpc)
		| "vm" ->               VM (API.Ref.of_string ev.Event_types.reference, maybe (API.vM_t_of_rpc) rpc)
		| "vm_metrics" ->       VM_metrics (API.Ref.of_string ev.Event_types.reference, maybe (API.vM_metrics_t_of_rpc) rpc)
		| "vm_guest_metrics" -> VM_guest_metrics (API.Ref.of_string ev.Event_types.reference, maybe (API.vM_guest_metrics_t_of_rpc) rpc)
		| "host" ->             Host (API.Ref.of_string ev.Event_types.reference, maybe (API.host_t_of_rpc) rpc)
		| "host_metrics" ->     Host_metrics (API.Ref.of_string ev.Event_types.reference, maybe (API.host_metrics_t_of_rpc) rpc)
		| "host_cpu" ->         Host_cpu (API.Ref.of_string ev.Event_types.reference, maybe (API.host_cpu_t_of_rpc) rpc)
		| "network" ->          Network (API.Ref.of_string ev.Event_types.reference, maybe (API.network_t_of_rpc) rpc)
		| "vif" ->              VIF (API.Ref.of_string ev.Event_types.reference, maybe (API.vIF_t_of_rpc) rpc)
		| "vif_metrics" ->      VIF_metrics (API.Ref.of_string ev.Event_types.reference, maybe (API.vIF_metrics_t_of_rpc) rpc)
		| "pif" ->              PIF (API.Ref.of_string ev.Event_types.reference, maybe (API.pIF_t_of_rpc) rpc)
		| "pif_metrics" ->      PIF_metrics (API.Ref.of_string ev.Event_types.reference, maybe (API.pIF_metrics_t_of_rpc) rpc)
		| "sr" ->               SR (API.Ref.of_string ev.Event_types.reference, maybe (API.sR_t_of_rpc) rpc)
		| "vdi" ->              VDI (API.Ref.of_string ev.Event_types.reference, maybe (API.vDI_t_of_rpc) rpc)
		| "vbd" ->              VBD (API.Ref.of_string ev.Event_types.reference, maybe (API.vBD_t_of_rpc) rpc)
		| "vbd_metrics" ->      VBD_metrics (API.Ref.of_string ev.Event_types.reference, maybe (API.vBD_metrics_t_of_rpc) rpc)
		| "pbd" ->              PBD (API.Ref.of_string ev.Event_types.reference, maybe (API.pBD_t_of_rpc) rpc)
		| "crashdump" ->        Crashdump (API.Ref.of_string ev.Event_types.reference, maybe (API.crashdump_t_of_rpc) rpc)
		| "vtpm" ->             VTPM (API.Ref.of_string ev.Event_types.reference, maybe (API.vTPM_t_of_rpc) rpc)
		| "console" ->          Console (API.Ref.of_string ev.Event_types.reference, maybe (API.console_t_of_rpc) rpc)
		| "user" ->             User (API.Ref.of_string ev.Event_types.reference, maybe (API.user_t_of_rpc) rpc)
		| "pool" ->             Pool (API.Ref.of_string ev.Event_types.reference, maybe (API.pool_t_of_rpc) rpc)
		| "message" ->          Message (API.Ref.of_string ev.Event_types.reference, maybe (API.message_t_of_rpc) rpc)
		| "secret" ->           Secret (API.Ref.of_string ev.Event_types.reference, maybe (API.secret_t_of_rpc) rpc)
		| "vmpp" ->             VMPP (API.Ref.of_string ev.Event_types.reference, maybe (API.vMPP_t_of_rpc) rpc)
		| _ -> failwith "unknown event type"
			  
