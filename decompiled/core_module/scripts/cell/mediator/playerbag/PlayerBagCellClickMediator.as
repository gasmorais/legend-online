package cell.mediator.playerbag
{
   import bag.datas.GoodsSonType;
   import bag.helper.BagHelper;
   import bag.helper.GoodsCheck;
   import bag.view.SpliteItemFrame;
   import cell.mediator.DoubleClickMediator;
   import cell.view.GoodsItemMenu;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.SoundManager;
   import events.FashionEvent;
   import flash.events.Event;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import managers.FreedomTeamManager;
   import managers.MopupManager;
   import managers.MountsManager;
   import managers.OfferRewardManager;
   import managers.TreasureMapManager;
   import map.campaign.CampaignManager;
   import mvc.controler.NewYearActController;
   import mvc.module.appell.AppellModel;
   import mvc.module.archeology.ArchaeologyModel;
   import mvc.module.buildings.OfferRewardModel;
   import mvc.module.fashion.FashionModel;
   import mvc.module.pet.PetData;
   import mvc.module.shop.ShopGoodsInfo;
   import org.aswing.KeyboardManager;
   import simplegame.christmasroses.SnowRosePresentView;
   import simplegame.roses.RosePresentView;
   import yishi.SwitchPageHelp;
   import yishi.datas.consant.ArmyPanelEnum;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerBufferInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.AppellInfoTemplate;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.MountTemplate;
   import yishi.manager.ArchaeologyManager;
   import yishi.manager.ArmyManager;
   import yishi.manager.CampaignTemplateManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerBufferManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.ResourceManager;
   import yishi.manager.StarGazingManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.MaskUtils;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.WorldBossHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.community.CrossBugleFrame;
   import yishi.view.community.RenameView;
   import yishi.view.tips.MessageTipManager;
   
   public class PlayerBagCellClickMediator extends DoubleClickMediator
   {
      
      private var _menu:GoodsItemMenu;
      
      public function PlayerBagCellClickMediator()
      {
         super();
      }
      
      override protected function __mouseClickByClicker(param1:Event) : void
      {
         var _loc5_:Boolean = false;
         var _loc10_:SpliteItemFrame = null;
         var _loc9_:Point = null;
         var _loc2_:Boolean = false;
         var _loc6_:int = 0;
         var _loc11_:int = 0;
         var _loc8_:Boolean = KeyboardManager.isDown(16);
         var _loc7_:Boolean = BagHelper.instance.isSelling;
         if(_loc7_)
         {
            return;
         }
         var _loc4_:GoodsInfo = _cell.data;
         if(!_loc4_)
         {
            return;
         }
         if(GoodsManager.instance.isSellPos(_loc4_))
         {
            return;
         }
         if(_loc8_ && _loc4_.templateId != 208003 && _loc4_.templateId != 208002)
         {
            NotificationManager.instance.sendNotification("SEND_GOODS",_loc4_);
            return;
         }
         var _loc3_:Boolean = BagHelper.instance.canSplite(_loc4_);
         if(_loc5_ && _loc3_)
         {
            param1.stopImmediatePropagation();
            _loc10_ = ComponentFactory.Instance.creatComponentByStylename("core.SpliteItemFrame");
            _loc10_.data = _cell;
            _loc10_.show();
            return;
         }
         if(_loc4_.templateInfo.SonType == 298)
         {
            FrameControllerManager.instance.openControllerByInfo("gradebox",null,_loc4_);
         }
         else if(_loc4_.templateInfo.MasterType == 2 || _loc4_.templateInfo.MasterType == 4)
         {
            _loc9_ = _cell.parent.localToGlobal(new Point(_cell.x,_cell.y));
            if(BagHelper.checkCanUseGoods(_loc4_.templateInfo.SonType) || BagHelper.checkCanUseGoods2(_loc4_.templateId))
            {
               _loc2_ = _loc4_.templateInfo.IsCanBatch;
               if(_loc4_.templateInfo.SonType == 311)
               {
                  switch(_loc4_.templateInfo.Property2)
                  {
                     case -800:
                        _loc6_ = thane.gloryPoint / _loc4_.templateInfo.Property3;
                        break;
                     case -700:
                        _loc6_ = playerInfo.strategy / _loc4_.templateInfo.Property3;
                        break;
                     case -600:
                        _loc6_ = ResourceManager.instance.waterCrystal.count / _loc4_.templateInfo.Property3;
                        break;
                     case -500:
                        _loc6_ = playerInfo.giftToken / _loc4_.templateInfo.Property3;
                        break;
                     case -400:
                        _loc6_ = playerInfo.point / _loc4_.templateInfo.Property3;
                        break;
                     case -300:
                        _loc6_ = playerInfo.strategy / _loc4_.templateInfo.Property3;
                        break;
                     case -200:
                        _loc6_ = playerInfo.mineral / _loc4_.templateInfo.Property3;
                        break;
                     case -100:
                        _loc6_ = ResourceManager.instance.gold.count / _loc4_.templateInfo.Property3;
                        break;
                     default:
                        _loc6_ = GoodsManager.instance.getGoodsNumByTempId(_loc4_.templateInfo.Property2) / _loc4_.templateInfo.Property3;
                  }
                  _loc11_ = Math.min(_loc6_,_loc4_.count);
                  if(_loc11_ > 1)
                  {
                     _loc2_ = true;
                  }
               }
               if(BagHelper.checkCanUseGoods2(_loc4_.templateId) && _loc4_.count > 1)
               {
                  _loc2_ = true;
               }
               if(_loc4_.templateId == 208044)
               {
                  _loc2_ = false;
               }
               showUseMenu(_loc9_.x + _cell.icon.iconWidth - 10,_loc9_.y + _cell.icon.iconHeight - 10,_cell,_loc2_);
               return;
            }
            if(BagHelper.checkisOnlyMove(_loc4_.templateInfo.SonType))
            {
               NotificationManager.instance.sendNotification("DRAG_ITEM_BagNotic",[_cell,_loc4_.count]);
            }
         }
         else
         {
            NotificationManager.instance.sendNotification("DRAG_ITEM_BagNotic",[_cell,_loc4_.count]);
         }
      }
      
      override protected function __mouseDoubleClick(param1:Event) : void
      {
         var _loc23_:String = null;
         var _loc24_:int = 0;
         var _loc17_:AppellInfoTemplate = null;
         var _loc14_:AppellModel = null;
         var _loc29_:GoodsTemplateInfo = null;
         var _loc25_:MountTemplate = null;
         var _loc15_:ConfigInfosTempInfo = null;
         var _loc16_:int = 0;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc7_:String = null;
         var _loc4_:String = null;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc26_:Boolean = false;
         var _loc27_:PlayerBufferInfo = null;
         var _loc13_:int = 0;
         var _loc12_:int = 0;
         var _loc22_:int = 0;
         var _loc2_:GoodsInfo = null;
         var _loc18_:int = 0;
         var _loc5_:int = 0;
         var _loc28_:Array = null;
         var _loc11_:Array = null;
         var _loc21_:int = 0;
         var _loc3_:GoodsInfo = _cell.data;
         if(!_loc3_)
         {
            return;
         }
         if(BagHelper.instance.isSelling)
         {
            return;
         }
         if(GoodsManager.instance.isSellPos(_loc3_))
         {
            return;
         }
         if(BagHelper.checkCanUseGoods2(_loc3_.templateId) || BagHelper.checkCanUseGoods(_loc3_.templateInfo.SonType))
         {
            if(_loc3_.templateInfo.SonType != 298 && !GoodsCheck.isGradeFix(ArmyManager.instance.thane,_loc3_.templateInfo,false))
            {
               _loc23_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command01");
               MessageTipManager.instance().show(_loc23_);
               return;
            }
            if(_loc3_.templateInfo.SonType == 294 && (_loc14_.sysCurTimeBySecond - playerInfo.lastOutConsortia >= 86400 || !playerInfo.isAuto))
            {
               _loc23_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command05");
               MessageTipManager.instance().show(_loc23_);
               return;
            }
            if(_loc3_.templateInfo.TemplateId == 2032102)
            {
               useGroupfbIncomeAlert(_loc3_);
            }
            else if(_loc3_.templateInfo.SonType == 277)
            {
               ChildManager.instance.checkForExchangeChild();
            }
            else if(_loc3_.templateInfo.SonType == 298)
            {
               FrameControllerManager.instance.openControllerByInfo("gradebox",null,_loc3_);
            }
            else if(_loc3_.templateInfo.SonType == 222)
            {
               FrameControllerManager.instance.openControllerByInfo("newyearact",NewYearActController.HANDLSEL,_loc3_);
            }
            else if(_loc3_.templateInfo.SonType == 278)
            {
               fashionModel.selectedPanel = "FASHION_PANEL";
               fashionModel.dispatchEvent(new FashionEvent("SWITCH_EQUIPVIEW",null));
               FrameControllerManager.instance.openControllerByInfo("fashion",0);
            }
            else if(_loc3_.templateInfo.SonType == 622)
            {
               if(SceneManager.instance.currentType != "OUTER_CITY_SCENE")
               {
                  _loc23_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command11");
                  MessageTipManager.instance().show(_loc23_);
               }
               else
               {
                  SocketSendManager.instance.sendUseItem(_loc3_.pos);
               }
            }
            else if(_loc3_.templateInfo.SonType == 209)
            {
               SocketSendManager.instance.sendUseItem(_loc3_.pos);
            }
            else if(_loc3_.templateInfo.SonType == 219)
            {
               SwitchPageHelp.openPumpingJoyFrame();
            }
            else if(_loc3_.templateInfo.SonType == 226)
            {
               ChildManager.instance.openFrame = 3;
               ChildManager.instance.openChildFram();
            }
            else if(_loc3_.templateInfo.SonType == 624)
            {
               ChildManager.instance.openChildNsFram(1);
            }
            else if(_loc3_.templateInfo.SonType == 221)
            {
               _loc24_ = _loc3_.templateInfo.Property1;
               _loc14_ = FrameControllerManager.instance.appellControler.model;
               if(_loc14_ && _loc14_.infos)
               {
                  _loc17_ = _loc14_.infos[_loc24_];
                  if(_loc17_ && _loc17_.isGet && _loc17_.IsLong == 0)
                  {
                     _loc23_ = LanguageMgr.GetTranslation("cell.view.GoodsItemMenu.cannot.useAppellCard");
                     MessageTipManager.instance().show(_loc23_);
                     return;
                  }
               }
               SocketSendManager.instance.sendUseItem(_loc3_.pos);
            }
            else if(_loc3_.templateId == 208044)
            {
               if(ChildManager.instance.model.applyInfo.state == 0)
               {
                  ChildManager.instance.openSexFram(_loc3_.pos);
               }
               else
               {
                  _loc23_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command10");
                  MessageTipManager.instance().show(_loc23_);
               }
            }
            else if(_loc3_.templateInfo.SonType == 320)
            {
               if(_loc3_.randomSkill5 == 1)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.outDateGoods"));
                  return;
               }
               TreasureMapManager.instance.useTreasureMap(_loc3_);
            }
            else if(_loc3_.templateInfo.SonType == 710)
            {
               SocketSendManager.instance.sendUseStelaItem(_loc3_.pos);
            }
            else if(_loc3_.templateInfo.SonType == 311)
            {
               switch(_loc3_.templateInfo.Property2)
               {
                  case -800:
                     if(thane.gloryPoint < _loc3_.templateInfo.Property3)
                     {
                        _loc23_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command08");
                        MessageTipManager.instance().show(_loc23_);
                     }
                     else
                     {
                        useBoxAlert(_loc3_);
                     }
                     break;
                  case -700:
                     if(playerInfo.strategy < _loc3_.templateInfo.Property3)
                     {
                        _loc23_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command08");
                        MessageTipManager.instance().show(_loc23_);
                     }
                     else
                     {
                        useBoxAlert(_loc3_);
                     }
                     break;
                  case -600:
                     if(ResourceManager.instance.waterCrystal.count < _loc3_.templateInfo.Property3)
                     {
                        _loc23_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command08");
                        MessageTipManager.instance().show(_loc23_);
                     }
                     else
                     {
                        useBoxAlert(_loc3_);
                     }
                     break;
                  case -500:
                     if(playerInfo.giftToken < _loc3_.templateInfo.Property3)
                     {
                        _loc23_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command08");
                        MessageTipManager.instance().show(_loc23_);
                     }
                     else
                     {
                        useBoxAlert(_loc3_);
                     }
                     break;
                  case -400:
                     if(playerInfo.point < _loc3_.templateInfo.Property3)
                     {
                        _loc23_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command08");
                        MessageTipManager.instance().show(_loc23_);
                     }
                     else
                     {
                        useBoxAlert(_loc3_);
                     }
                     break;
                  case -300:
                     if(playerInfo.strategy < _loc3_.templateInfo.Property3)
                     {
                        _loc23_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command08");
                        MessageTipManager.instance().show(_loc23_);
                     }
                     else
                     {
                        useBoxAlert(_loc3_);
                     }
                     break;
                  case -200:
                     if(playerInfo.mineral < _loc3_.templateInfo.Property2)
                     {
                        _loc23_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command08");
                        MessageTipManager.instance().show(_loc23_);
                     }
                     else
                     {
                        useBoxAlert(_loc3_);
                     }
                     break;
                  case -100:
                     if(ResourceManager.instance.gold.count < _loc3_.templateInfo.Property3)
                     {
                        _loc23_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command08");
                        MessageTipManager.instance().show(_loc23_);
                     }
                     else
                     {
                        useBoxAlert(_loc3_);
                     }
                     break;
                  default:
                     if(GoodsManager.instance.getGoodsNumByTempId(_loc3_.templateInfo.Property2) < _loc3_.templateInfo.Property3)
                     {
                        _loc23_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command08");
                        MessageTipManager.instance().show(_loc23_);
                     }
                     else
                     {
                        useBoxAlert(_loc3_);
                     }
               }
            }
            else if(_loc3_.templateInfo.SonType == 292)
            {
               if(MopupManager.instance.model.isMopup)
               {
                  _loc23_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
                  MessageTipManager.instance().show(_loc23_);
                  return;
               }
               MaskUtils.instance.maskShow(0);
               SocketSendManager.instance.sendUseVipMoney();
            }
            else if(_loc3_.templateInfo.SonType == 217)
            {
               CheckUIModuleUtil.instance.tryCall("friends",openRosePresentCall,[_cell.data]);
            }
            else if(_loc3_.templateInfo.SonType == 280)
            {
               CheckUIModuleUtil.instance.tryCall("core",openCrossBugleCall,[_cell.data]);
            }
            else if(_loc3_.templateInfo.SonType == 289)
            {
               CheckUIModuleUtil.instance.tryCall("rename",openRenameCall,[_cell.data]);
            }
            else if(_loc3_.templateInfo.SonType == 218)
            {
               _loc29_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_.templateId);
               _loc25_ = TempleteManager.instance.mountTemplateDic[_loc29_.Property1];
               _loc15_ = TempleteManager.instance.getConfigInfoByConfigName("mount_card_resolve_multiple");
               _loc16_ = _loc25_.Power * parseInt(_loc15_.ConfigValue);
               if(MountsManager.instance.avatarList.isLightTemplate(_loc29_.Property1))
               {
                  if(_loc29_.Property2 != -1)
                  {
                     MountsManager.instance.sendUseGoods(_loc3_,false);
                  }
                  else
                  {
                     if(_loc29_.Refresh == -1)
                     {
                        MessageTipManager.instance().show(LanguageMgr.GetTranslation("cell.mediator.playerbag.useMountCardAlert2"));
                        return;
                     }
                     SimpleAlertHelper.instance.data = [__mountCardUserHandler,_loc3_];
                     _loc9_ = LanguageMgr.GetTranslation("public.confirm");
                     _loc10_ = LanguageMgr.GetTranslation("public.cancel");
                     _loc7_ = LanguageMgr.GetTranslation("public.prompt");
                     _loc4_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.useMountCardAlert",_loc16_);
                     SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc4_,_loc9_,_loc10_,true,true);
                  }
               }
               else
               {
                  MountsManager.instance.sendUseGoods(_loc3_,true);
               }
            }
            else if(_loc3_.templateInfo.SonType == 340)
            {
               SocketSendManager.instance.sendUseSexChangeCard(_loc3_.pos);
            }
            else if(_loc3_.templateInfo.SonType == 302)
            {
               FrameControllerManager.instance.armyController.startFrameByType(ArmyPanelEnum.SKILL_PANEL,1);
            }
            else if(_loc3_.templateInfo.SonType == 308)
            {
               checkForUsePetExpBook(_loc3_);
            }
            else if(_loc3_.templateInfo.SonType == 313)
            {
               checkForUsePetLandTransfer(_loc3_);
            }
            else if(_loc3_.templateInfo.SonType == 399)
            {
               CheckUIModuleUtil.instance.tryCall("friends",openSnowRosePresentCall,[_cell.data]);
            }
            else if(_loc3_.templateInfo.SonType == 315)
            {
               if(thane.grades < 60)
               {
                  _loc23_ = LanguageMgr.GetTranslation("singlepass.bugle.SinglePassBugleFrame.CannotUseTips",60);
                  MessageTipManager.instance().show(_loc23_);
                  return;
               }
               FrameControllerManager.instance.openControllerByInfo("singlepass",2);
            }
            else if(_loc3_.templateId == 208044)
            {
               if(ChildManager.instance.model.applyInfo.state == 0)
               {
                  ChildManager.instance.openSexFram(_loc3_.pos);
               }
            }
            else if(_loc3_.templateInfo.SonType == 800)
            {
               if(archaeologyModel.getGradeByExp(archaeologyModel.exp) < 3)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("ArchaeologyMakeRightView.stargazingBtn.tipdata"));
                  return;
               }
               _loc6_ = 0;
               if(_loc3_.templateInfo.TemplateId == 8001001 || _loc3_.templateInfo.TemplateId == 8001002)
               {
                  _loc6_ = 0;
               }
               else if(_loc3_.templateInfo.TemplateId == 8001015)
               {
                  _loc6_ = 1;
               }
               else if(_loc3_.templateInfo.TemplateId == 8001016 || _loc3_.templateInfo.TemplateId == 8001017)
               {
                  _loc6_ = 2;
               }
               FrameControllerManager.instance.openControllerByInfo("stargazing",null,_loc6_);
            }
            else if(_loc3_.templateInfo.SonType == 801)
            {
               if(archaeologyModel.getGradeByExp(archaeologyModel.exp) < 3)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("ArchaeologyMakeRightView.stargazingBtn.tipdata"));
                  return;
               }
               StarGazingManager.instance.model.selectStarIndex = _loc3_.templateInfo.Property1;
               FrameControllerManager.instance.openControllerByInfo("stargazing",null,1);
            }
            else if(_loc3_.templateInfo.SonType == 510)
            {
               _loc8_ = _loc3_.templateInfo.Property2;
               _loc26_ = CampaignTemplateManager.instance.isOpenByActiveCampaign(_loc8_);
               if(!_loc26_)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("campaign.Goods.AddNum.isOpen"));
                  return;
               }
               SocketSendManager.instance.sendUseItem(_loc3_.pos);
            }
            else if(check())
            {
               _loc27_ = PlayerBufferManager.instance.getItemBufferInfo(_loc3_.templateInfo.Property1);
               if(_loc27_)
               {
                  if(_loc3_.templateInfo.Property3 < _loc27_.grade)
                  {
                     _loc23_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command02");
                     MessageTipManager.instance().show(_loc23_);
                     return;
                  }
                  SocketSendManager.instance.sendUseItem(_loc3_.pos);
               }
               else
               {
                  if(_loc3_.templateInfo.Property1 == 5 && _loc3_.templateInfo.Property2 > 0)
                  {
                     _loc13_ = _loc3_.templateInfo.Property2;
                     _loc12_ = _loc3_.pos;
                     _loc22_ = 1;
                     if(!checkWearyCanGet(_loc13_,_loc12_,_loc22_))
                     {
                        return;
                     }
                     if(!checkWearyTodayCanGet(_loc13_,_loc12_,_loc22_))
                     {
                        return;
                     }
                  }
                  SocketSendManager.instance.sendUseItem(_loc3_.pos);
               }
            }
            return;
         }
         if(!checkGoodsByHero())
         {
            return;
         }
         if(!GoodsCheck.checkGoodsCanEquip(_loc3_,thane,false))
         {
            return;
         }
         if(!GoodsCheck.isGradeFix(thane,_loc3_.templateInfo,true))
         {
            return;
         }
         var _loc20_:int = -1;
         if(_loc3_.templateInfo.SonType == 214)
         {
            FrameControllerManager.instance.armyController.frame["defaultContent"] = ArmyPanelEnum.EQUIP_PANEL;
            _loc2_ = GoodsManager.instance.getBattleRunesByTempId(_loc3_.templateId);
            _loc20_ = GoodsManager.instance.getEmputyBattleRunesPos();
            if(_loc2_ && _loc2_.count != _loc2_.templateInfo.MaxCount)
            {
               _loc18_ = _loc2_.templateInfo.MaxCount - _loc2_.count;
               _loc18_ = _loc3_.count > _loc18_ ? _loc18_ : _loc3_.count;
               SoundManager.instance.play("024",true);
               fashionModel.selectedPanel = "EQUIP_PANEL";
               fashionModel.dispatchEvent(new FashionEvent("SWITCH_EQUIPVIEW",null));
               PlayerManager.instance.moveBagToBag(_cell.bagType,_cell.objectId,_cell.pos,2,thane.id,_loc2_.pos,_loc18_);
            }
            else if(_loc20_ != -1)
            {
               SoundManager.instance.play("024",true);
               fashionModel.selectedPanel = "EQUIP_PANEL";
               fashionModel.dispatchEvent(new FashionEvent("SWITCH_EQUIPVIEW",null));
               PlayerManager.instance.moveBagToBag(_cell.bagType,_cell.objectId,_cell.pos,2,thane.id,_loc20_,_loc3_.count);
            }
         }
         else if(_loc3_.templateInfo.MasterType == 3)
         {
            FrameControllerManager.instance.armyController.frame["defaultContent"] = ArmyPanelEnum.EQUIP_PANEL;
            _loc20_ = GoodsManager.instance.getEmputyHonerPos();
            if(_loc20_ == -1)
            {
               _loc20_ = 0;
            }
            SoundManager.instance.play("024",true);
            fashionModel.selectedPanel = "EQUIP_PANEL";
            fashionModel.dispatchEvent(new FashionEvent("SWITCH_EQUIPVIEW",null));
            PlayerManager.instance.moveBagToBag(_cell.bagType,_cell.objectId,_cell.pos,3,thane.id,_loc20_,_loc3_.count);
         }
         else
         {
            _loc5_ = 4;
            FrameControllerManager.instance.armyController.frame["defaultContent"] = ArmyPanelEnum.EQUIP_PANEL;
            _loc28_ = GoodsManager.instance.getHeroGoodsListByTypeAndId(_loc3_.templateInfo.MasterType,thane.id).getList();
            _loc11_ = GoodsSonType.getSonTypePos(GoodsInfo(_loc3_).templateInfo.SonType);
            _loc28_.sortOn("pos");
            _loc21_ = 0;
            if(_loc11_.length > 1)
            {
               for each(var _loc19_:GoodsInfo in _loc28_)
               {
                  if(_loc19_.bagType == _loc5_ && _loc19_.templateInfo.SonType == GoodsInfo(_loc3_).templateInfo.SonType && _loc19_.pos == _loc11_[0] + _loc21_)
                  {
                     _loc21_++;
                  }
               }
               if(_loc21_ >= _loc11_.length)
               {
                  _loc20_ = int(_loc11_[0]);
               }
               else
               {
                  _loc20_ = int(_loc11_[_loc21_]);
               }
            }
            else
            {
               _loc20_ = int(_loc11_[0]);
            }
            if(_loc20_ != -1)
            {
               SoundManager.instance.play("024",true);
               if(fashionModel.isFashion(_loc3_))
               {
                  fashionModel.selectedPanel = "FASHION_PANEL";
                  fashionModel.dispatchEvent(new FashionEvent("SWITCH_EQUIPVIEW",null));
                  FrameControllerManager.instance.openControllerByInfo("fashion",0);
                  return;
               }
               fashionModel.selectedPanel = "EQUIP_PANEL";
               fashionModel.dispatchEvent(new FashionEvent("SWITCH_EQUIPVIEW",null));
               if(_cell.data.templateInfo.SonType == 117 || _cell.data.templateInfo.SonType == 118)
               {
                  if(_cell.data.templateInfo.NeedChangeJob == 2)
                  {
                     if(!thane.isAvenger)
                     {
                        _loc23_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellDropMediator.equipCanJoin2");
                        MessageTipManager.instance().show(_loc23_);
                        return;
                     }
                  }
                  else if(thane.vocationGrades <= 0)
                  {
                     _loc23_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellDropMediator.equipCanJoin");
                     MessageTipManager.instance().show(_loc23_);
                     return;
                  }
               }
               PlayerManager.instance.moveBagToBag(_cell.bagType,_cell.objectId,_cell.pos,_loc5_,thane.id,_loc20_,1);
            }
         }
      }
      
      private function __mountCardUserHandler(param1:Boolean, param2:Boolean, param3:GoodsInfo) : void
      {
         if(param1)
         {
            MountsManager.instance.sendUseGoods(param3,false);
         }
      }
      
      private function useGroupfbIncomeAlert(param1:GoodsInfo) : void
      {
         SimpleAlertHelper.instance.data = [useGroupfbIncomeBack,param1];
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc2_:String = LanguageMgr.GetTranslation("PlayerBagCellClickMediator.useGroupfbIncome.Tips",param1.templateInfo.Property3);
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc2_,_loc3_,_loc4_);
      }
      
      private function useGroupfbIncomeBack(param1:Boolean, param2:Boolean, param3:GoodsInfo) : void
      {
         var _loc4_:String = null;
         if(param1)
         {
            if(thane.vocationGrades <= 0)
            {
               _loc4_ = LanguageMgr.GetTranslation("fund.fundRewardView.NewbieTip");
               MessageTipManager.instance().show(_loc4_);
               return;
            }
            if(playerInfo.weary < param3.templateInfo.Property3)
            {
               _loc4_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData03");
               MessageTipManager.instance().show(_loc4_);
               return;
            }
            SocketSendManager.instance.sendUseItem(param3.pos);
         }
      }
      
      private function useBoxAlert(param1:*) : void
      {
         SimpleAlertHelper.instance.data = [checkForUseBox,param1];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1.templateInfo.Property2).TemplateName;
         var _loc6_:String = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command09",1,param1.templateInfo.TemplateName,1 * param1.templateInfo.Property3,_loc5_);
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc6_,_loc2_,_loc3_,true,true,true);
      }
      
      private function checkForUseBox(param1:Boolean, param2:Boolean, param3:*) : void
      {
         if(param1)
         {
            SocketSendManager.instance.sendUseItem(param3.pos);
         }
      }
      
      private function checkForUsePetExpBook(param1:GoodsInfo) : void
      {
         SimpleAlertHelper.instance.data = [checkForUsePetExpBookBack,param1];
         var _loc4_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc3_:String = LanguageMgr.GetTranslation("checkForUsePetExpBook.content02",param1.templateInfo.Property2);
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc3_,_loc4_,_loc2_,true,true,true);
      }
      
      private function checkForUsePetExpBookBack(param1:Boolean, param2:Boolean, param3:GoodsInfo) : void
      {
         var _loc4_:String = null;
         if(!param1)
         {
            return;
         }
         if(!param3)
         {
            return;
         }
         var _loc5_:PetData = playerInfo.enterWarPet;
         if(!_loc5_)
         {
            _loc4_ = LanguageMgr.GetTranslation("checkForUsePetExpBook.content01");
            MessageTipManager.instance().show(_loc4_);
            return;
         }
         if(_loc5_.isFullExp())
         {
            _loc4_ = LanguageMgr.GetTranslation("PetSwallowView.fullExp");
            MessageTipManager.instance().show(_loc4_);
            return;
         }
         SocketSendManager.instance.sendUseItem(param3.pos);
      }
      
      private function checkForUsePetLandTransfer(param1:GoodsInfo) : void
      {
         var _loc5_:String = null;
         var _loc3_:String = null;
         var _loc7_:String = null;
         var _loc4_:String = null;
         var _loc2_:String = null;
         var _loc6_:Boolean = false;
         switch(SceneManager.instance.currentType)
         {
            case "SPACE_SCENE":
            case "CASTLE_SCENE":
            case "FARM":
               _loc6_ = true;
               break;
            case "CAMPAIGN_MAP_SCENE":
               if(CampaignManager.instance.mapModel)
               {
                  if(WorldBossHelper.checkPetLand(CampaignManager.instance.mapId))
                  {
                     _loc6_ = true;
                  }
               }
               break;
            default:
               _loc6_ = false;
         }
         if(_loc6_)
         {
            SimpleAlertHelper.instance.data = [checkForUsePetLandTransferBack,param1];
            _loc5_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc7_ = LanguageMgr.GetTranslation("public.prompt");
            _loc4_ = LanguageMgr.GetTranslation("checkForUsePetLandTransfer.content01",getPetLandLevel(param1.templateInfo.Property1));
            SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc4_,_loc5_,_loc3_,true,true,true);
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("checkForUsePetLandTransfer.content02");
            MessageTipManager.instance().show(_loc2_);
         }
      }
      
      private function checkForUsePetLandTransferBack(param1:Boolean, param2:Boolean, param3:GoodsInfo) : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(!param1)
         {
            return;
         }
         if(!param3)
         {
            return;
         }
         if(MopupManager.instance.model.isMopup)
         {
            _loc4_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc4_);
            return;
         }
         if(FreedomTeamManager.instance.model != null && FreedomTeamManager.instance.model.followFlag)
         {
            FreedomTeamManager.instance.model.followFlag = false;
            _loc5_ = LanguageMgr.GetTranslation("map.internals.mediator.team.FreedomTeamFollowMediator.Tips02");
            MessageTipManager.instance().show(_loc5_);
         }
         PlayerManager.instance.currentPlayerModel.inCastle = false;
         SocketSendManager.instance.sendUseItem(param3.pos);
      }
      
      private function getPetLandLevel(param1:int) : String
      {
         var _loc2_:String = LanguageMgr.GetTranslation("checkForUsePetLandTransfer.level01");
         switch(param1 - 20001)
         {
            case 0:
               _loc2_ = LanguageMgr.GetTranslation("checkForUsePetLandTransfer.level01");
               break;
            case 1:
               _loc2_ = LanguageMgr.GetTranslation("checkForUsePetLandTransfer.level02");
               break;
            case 2:
               _loc2_ = LanguageMgr.GetTranslation("checkForUsePetLandTransfer.level03");
               break;
            case 3:
               _loc2_ = LanguageMgr.GetTranslation("checkForUsePetLandTransfer.level04");
         }
         return _loc2_;
      }
      
      private function checkWearyCanGet(param1:int, param2:int, param3:int = 1) : Boolean
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc6_:int = 200 - playerInfo.weary;
         if(param1 > _loc6_)
         {
            SimpleAlertHelper.instance.data = [wearyCanGetCallBack,param1,param2,param3];
            _loc4_ = LanguageMgr.GetTranslation("public.confirm");
            _loc5_ = LanguageMgr.GetTranslation("public.cancel");
            _loc7_ = LanguageMgr.GetTranslation("map.campaign.view.frame.SubmitResourcesFrame.titleTextTip");
            _loc8_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command07",_loc6_);
            SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc8_,_loc4_,_loc5_,true,true,true);
            return false;
         }
         return true;
      }
      
      private function checkWearyTodayCanGet(param1:int, param2:int, param3:int = 1) : Boolean
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc6_:int = 600 - playerInfo.wearyLimit;
         if(param1 > _loc6_)
         {
            SimpleAlertHelper.instance.data = [wearyTodayCanGetCallBack,param1,param2,param3,true];
            _loc4_ = LanguageMgr.GetTranslation("public.confirm");
            _loc5_ = LanguageMgr.GetTranslation("public.cancel");
            _loc7_ = LanguageMgr.GetTranslation("map.campaign.view.frame.SubmitResourcesFrame.titleTextTip");
            _loc8_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command06",600,_loc6_);
            SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc8_,_loc4_,_loc5_,true,true,true);
            return false;
         }
         return true;
      }
      
      private function wearyCanGetCallBack(param1:Boolean, param2:Boolean, param3:int, param4:int, param5:int = 1) : void
      {
         if(param1)
         {
            if(checkWearyTodayCanGet(param3,param4,param5))
            {
               SocketSendManager.instance.sendUseItem(param4,param5);
            }
         }
      }
      
      private function wearyTodayCanGetCallBack(param1:Boolean, param2:Boolean, param3:int, param4:int, param5:int = 1, param6:Boolean = false) : void
      {
         if(param1)
         {
            SocketSendManager.instance.sendUseItem(param4,param5);
         }
      }
      
      private function openRosePresentCall(param1:Array) : void
      {
         var _loc2_:RosePresentView = ComponentFactory.Instance.creatComponentByStylename("friends.RosePresentView");
         _loc2_.setData(param1[0]);
         _loc2_.show();
      }
      
      private function openRenameCall(param1:Array) : void
      {
         var _loc2_:RenameView = new RenameView(1,null,param1[0]);
         _loc2_.show();
      }
      
      private function openCrossBugleCall(param1:Array) : void
      {
         var _loc2_:CrossBugleFrame = ComponentFactory.Instance.creatComponentByStylename("core.CrossBugleFrame");
         _loc2_.setData(param1[0]);
         _loc2_.show();
      }
      
      private function openSnowRosePresentCall(param1:Array) : void
      {
         var _loc2_:SnowRosePresentView = ComponentFactory.Instance.creatComponentByStylename("friends.SnowRosePresentView");
         _loc2_.setData(param1[0]);
         _loc2_.show();
      }
      
      private function startMoveBagToBag(param1:Boolean, param2:Boolean, param3:Array) : void
      {
         if(param1)
         {
            fashionModel.selectedPanel = "EQUIP_PANEL";
            fashionModel.dispatchEvent(new FashionEvent("SWITCH_EQUIPVIEW",null));
            PlayerManager.instance.moveBagToBag(param3[0],param3[1],param3[2],param3[3],param3[4],param3[5],param3[6]);
         }
      }
      
      private function check() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:String = "";
         var _loc3_:Boolean = ShopGoodsInfo.CONSORTIA_USE_ITEM.indexOf(_cell.data.templateInfo.Property1) != -1;
         if(_cell.data.templateInfo.SonType == 203 && _loc3_ && playerInfo.consortiaID == 0)
         {
            _loc1_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command03");
            MessageTipManager.instance().show(_loc1_);
            return false;
         }
         if(_cell.data.templateInfo.SonType == 211 && playerInfo.composeList.indexOf(_cell.data.templateInfo.Property1) >= 0)
         {
            _loc1_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command04");
            MessageTipManager.instance().show(_loc1_);
            return false;
         }
         if(_cell.data.templateInfo.SonType == 213)
         {
            if(MopupManager.instance.model.isMopup)
            {
               _loc1_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
               MessageTipManager.instance().show(_loc1_);
               return false;
            }
            if(rewardModel.baseRewardDic.getList().length >= 1)
            {
               _loc1_ = LanguageMgr.GetTranslation("buildings.offerreward.view.OfferTaskItem.command01");
               MessageTipManager.instance().show(_loc1_);
               return false;
            }
            if(rewardModel.remainRewardCount <= 0)
            {
               _loc1_ = LanguageMgr.GetTranslation("buildings.offerreward.view.OfferTaskItem.command02");
               MessageTipManager.instance().show(_loc1_);
               return false;
            }
         }
         if(_cell.data.templateInfo.SonType == 306)
         {
            _loc2_ = int(playerInfo.petList.length);
            if(_loc2_ >= playerInfo.petMaxCount)
            {
               _loc1_ = LanguageMgr.GetTranslation("usePetCard.MaxNumber");
               MessageTipManager.instance().show(_loc1_);
               return false;
            }
         }
         return true;
      }
      
      private function showUseMenu(param1:int, param2:int, param3:BaseItemView, param4:Boolean) : void
      {
         if(_cell.bagType == 6)
         {
            NotificationManager.instance.sendNotification("DRAG_ITEM_BagNotic",[this]);
            return;
         }
         _menu = ComponentFactory.Instance.creatCustomObject("core.GoodsItemMenu",[param3,param4]);
         _menu.x = param1;
         _menu.y = param2;
         LayerManager.Instance.addToLayer(_menu,7);
      }
      
      public function checkGoodsByHero(param1:Boolean = true) : Boolean
      {
         return GoodsCheck.checkGoodsByHero(_cell.data,thane,param1);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get model() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get rewardModel() : OfferRewardModel
      {
         return OfferRewardManager.instance.model;
      }
      
      private function get fashionModel() : FashionModel
      {
         return FrameControllerManager.instance.fashionCodeController.model;
      }
      
      private function get archaeologyModel() : ArchaeologyModel
      {
         return ArchaeologyManager.instance.model;
      }
   }
}

