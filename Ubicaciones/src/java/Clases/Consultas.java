/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Clases;

/**
 *
 * @author amerikillo
 */
public class Consultas {

    String query;

    public String cons_todos(String juris) {
        query = "select sum(can_sur) from juris where juris = '" + juris + "'";
        return query;
    }

    public String qry_clave_descr(String clave) {
        query = "select ori, cla_ins, des_ins from insumo where cla_ins = '" + clave + "'";
        return query;
    }

    public String qry_eliminar_usuarios() {
        query = "select id_usu, user from usuarios where status != '0'";
        return query;
    }

    public String qry_sectores() {
        query = "select id_sector, sector_des from sectores";
        return query;
    }

    public String qry_lote_clave(String clave) {
        query = "select lote from det_insumo where cla_ins = '" + clave + "' group by lote";
        return query;
    }

    public String qry_ubicaciones(String ubicacion) {
        query = "select id_ubi, des_ubi from ubicaciones where des_ubi != '" + ubicacion + "'";
        return query;
    }

    public String qry_alta_claves(String user) {
        query = "SELECT di.id_detins, di.cla_ins, di.lote, i.des_ins, di.caducidad, u.des_ubi, s.sector_des, di.cant, di.cant_caja\n"
                + "from det_insumo di, insumo i, ubicaciones u, sectores s, registro r, usuarios us\n"
                + "WHERE\n"
                + "di.cla_ins = i.cla_ins and\n"
                + "di.id_ubi = u.id_ubi AND\n"
                + "di.id_sec = s.id_sector and\n"
                + "di.id_detins = r.id_detins AND\n"
                + "r.idUsuario = us.id_usu AND\n"
                + "i.status != '0' and\n"
                + "us.user = '" + user + "' and di.status != '0'\n"
                + "order by u.des_ubi;";
        return query;
    }

    public String qry_modi_claves(String det_ins) {
        query = "SELECT i.ori, di.cla_ins, di.lote, i.des_ins, di.caducidad, u.des_ubi, s.sector_des, di.cant, di.id_ubi, di.cant_caja\n"
                + "from det_insumo di, insumo i, ubicaciones u, sectores s, registro r, usuarios us\n"
                + "WHERE\n"
                + "di.cla_ins = i.cla_ins and\n"
                + "di.id_ubi = u.id_ubi AND\n"
                + "di.id_sec = s.id_sector and\n"
                + "di.id_detins = r.id_detins AND\n"
                + "r.idUsuario = us.id_usu AND\n"
                + "i.status != '0' and\n"
                + "di.id_detins = '" + det_ins + "'\n"
                + "and di.status!='0' order by u.des_ubi;";
        return query;
    }

    public String qry_main_todos() {
        query = "SELECT di.id_detins, di.cla_ins, di.lote, i.des_ins, di.caducidad, u.des_ubi, s.sector_des, di.cant, di.id_ubi, di.cant_caja\n"
                + "from det_insumo di, insumo i, ubicaciones u, sectores s, registro r, usuarios us\n"
                + "WHERE\n"
                + "di.cla_ins = i.cla_ins and\n"
                + "di.id_ubi = u.id_ubi AND\n"
                + "di.id_sec = s.id_sector and\n"
                + "di.id_detins = r.id_detins AND\n"
                + "r.idUsuario = us.id_usu and di.status !='0'\n"
                + "group by di.id_detins\n"
                + "order by u.des_ubi;";
        System.out.println(query);
        return query;
    }

    public String qry_main_ubicacion(String ubicacion) {
        query = "SELECT di.id_detins, di.cla_ins, di.lote, i.des_ins, di.caducidad, u.des_ubi, s.sector_des, di.cant, di.id_ubi, di.cant_caja\n"
                + "from det_insumo di, insumo i, ubicaciones u, sectores s, registro r, usuarios us\n"
                + "WHERE\n"
                + "di.cla_ins = i.cla_ins and\n"
                + "di.id_ubi = u.id_ubi AND\n"
                + "di.id_sec = s.id_sector and\n"
                + "di.id_detins = r.id_detins AND\n"
                + "r.idUsuario = us.id_usu AND u.id_ubi = '" + ubicacion + "' and di.status !='0'\n"
                + "group by di.id_detins\n"
                + "order by u.des_ubi;";
        System.out.println(query);
        return query;
    }

    public String qry_main_clave(String clave) {
        query = "SELECT di.id_detins, di.cla_ins, di.lote, i.des_ins, di.caducidad, u.des_ubi, s.sector_des, di.cant, di.id_ubi, di.cant_caja\n"
                + "from det_insumo di, insumo i, ubicaciones u, sectores s, registro r, usuarios us\n"
                + "WHERE\n"
                + "di.cla_ins = i.cla_ins and\n"
                + "di.id_ubi = u.id_ubi AND\n"
                + "di.id_sec = s.id_sector and\n"
                + "di.id_detins = r.id_detins AND\n"
                + "r.idUsuario = us.id_usu AND di.cla_ins = '" + clave + "' and di.status !='0'\n"
                + "group by di.id_detins\n"
                + "order by u.des_ubi;";
        System.out.println(query);
        return query;
    }

    public String qry_main_lote(String lote) {
        query = "SELECT di.id_detins, di.cla_ins, di.lote, i.des_ins, di.caducidad, u.des_ubi, s.sector_des, di.cant, di.id_ubi, di.cant_caja\n"
                + "from det_insumo di, insumo i, ubicaciones u, sectores s, registro r, usuarios us\n"
                + "WHERE\n"
                + "di.cla_ins = i.cla_ins and\n"
                + "di.id_ubi = u.id_ubi AND\n"
                + "di.id_sec = s.id_sector and\n"
                + "di.id_detins = r.id_detins AND\n"
                + "r.idUsuario = us.id_usu AND di.lote = '" + lote + "' and di.status !='0'\n"
                + "group by di.id_detins\n"
                + "order by u.des_ubi;";
        System.out.println(query);
        return query;
    }

    public String qry_main_porubicar() {
        query = "SELECT di.id_detins, di.cla_ins, di.lote, i.des_ins, di.caducidad, u.des_ubi, s.sector_des, di.cant, di.id_ubi, di.cant_caja\n"
                + "from det_insumo di, insumo i, ubicaciones u, sectores s, registro r, usuarios us\n"
                + "WHERE\n"
                + "di.cla_ins = i.cla_ins and\n"
                + "di.id_ubi = u.id_ubi AND\n"
                + "di.id_sec = s.id_sector and\n"
                + "di.id_detins = r.id_detins AND\n"
                + "r.idUsuario = us.id_usu AND u.id_ubi = '1000' and\n"
                + "di.status != '0' and di.status !='0'\n"
                + "order by u.des_ubi;";
        System.out.println(query);
        return query;
    }

    public String qry_kardex_claves() {
        query = "select cla_ins from det_insumo group by cla_ins order by cla_ins+0";
        System.out.println(query);
        return query;
    }

    public String qry_kardex_lote() {
        query = "select lote from registro group by lote order by lote+0";
        System.out.println(query);
        return query;
    }

    public String qry_kardex_caducidad() {
        query = "select caducidad from registro group by caducidad order by caducidad";
        System.out.println(query);
        return query;
    }

    public String qry_kardex_ubicacion() {
        query = "select r.id_ubi, u.des_ubi from registro r, det_insumo d, ubicaciones u"
                + " where r.id_detins=d.id_detins and"
                + " d.id_ubi = u.id_ubi group by r.id_ubi order by r.id_ubi";
        System.out.println(query);
        return query;
    }

    public String qry_kardex_usuario() {
        query = "select r.idUsuario, u.user from registro r, usuarios u where r.idUsuario = u.id_usu group by u.user order by u.user";
        System.out.println(query);
        return query;
    }

    public String qry_kardex_movimiento() {
        query = "select tipo_mov from registro group by tipo_mov order by tipo_mov";
        System.out.println(query);
        return query;
    }

    public String qry_kardex_consulta(String clave, String lote, String cad, String ubi, String usu, String mov) {
        query = "SELECT di.cla_ins, r.lote, r.caducidad, r.cant, r.cant_caja, u.des_ubi, r.tipo_mov, r.fec_hor, us.user \n"
                + "from det_insumo di, ubicaciones u, registro r, usuarios us\n"
                + "where \n"
                + "di.id_detins = r.id_detins and\n"
                + "u.id_ubi = di.id_ubi AND\n"
                + "r.idusuario = us.id_usu AND\n"
                + "di.cla_ins like '%"+clave+"%' AND\n"
                + "r.lote like '%"+lote+"%' AND\n"
                + "r.caducidad like '%"+cad+"%' AND\n"
                + "r.id_ubi like '%"+ubi+"%' AND\n"
                + "r.idUsuario like '%"+usu+"%' AND\n"
                + "r.tipo_mov like '%"+mov+"%'\n"
                + ";";
        System.out.println(query);
        return query;
    }

}
