package cell.view
{
   import bag.helper.BagHelper;
   import bag.helper.GoodsCheck;
   import bag.view.MulItemUseFrame;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import events.FashionEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
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
   
   public class GoodsItemMenu extends Sprite implements Disposeable
   {
      
      private var _currentItem:BaseItemView;
      
      private var _back:ScaleBitmapImage;
      
      private var _useBtn:TextButton;
      
      private var _moveBtn:TextButton;
      
      private var _mulBtn:TextButton;
      
      private var _vBox:VBox;
      
      private var _showMuti:Boolean;
      
      public function GoodsItemMenu(param1:BaseItemView, param2:Boolean = true)
      {
         super();
         _currentItem = param1;
         _showMuti = param2;
         init();
         initEvent();
      }
      
      private function init() : void
      {
         _useBtn = ComponentFactory.Instance.creatComponentByStylename("core.UseButton");
         _useBtn.text = LanguageMgr.GetTranslation("cell.view.GoodsItemMenu.use");
         _moveBtn = ComponentFactory.Instance.creatComponentByStylename("core.MoveButton");
         _moveBtn.text = LanguageMgr.GetTranslation("cell.view.GoodsItemMenu.move");
         _mulBtn = ComponentFactory.Instance.creatComponentByStylename("core.MulUseButton");
         _mulBtn.text = LanguageMgr.GetTranslation("cell.view.GoodsItemMenu.mul");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("core.GoodsItemMenuContain");
         _vBox.addChild(_useBtn);
         _vBox.addChild(_moveBtn);
         if(_showMuti)
         {
            _vBox.addChild(_mulBtn);
         }
         addChild(_vBox);
      }
      
      private function initEvent() : void
      {
         _useBtn.addEventListener("click",__userHandler);
         _moveBtn.addEventListener("click",__moveHandler);
         _mulBtn.addEventListener("click",__useMulHandler);
      }
      
      private function removeEvent() : void
      {
         if(_useBtn)
         {
            _useBtn.removeEventListener("click",__userHandler);
         }
         if(_moveBtn)
         {
            _moveBtn.removeEventListener("click",__moveHandler);
         }
         if(_mulBtn)
         {
            _mulBtn.removeEventListener("click",__useMulHandler);
         }
      }
      
      private function __moveHandler(param1:MouseEvent) : void
      {
         if(_currentItem && _currentItem.data)
         {
            NotificationManager.instance.sendNotification("DRAG_ITEM_BagNotic",[_currentItem,_currentItem.data.count]);
         }
         dispose();
      }
      
      private function __useMulHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(_currentItem.data.templateInfo.SonType != 298 && !GoodsCheck.isGradeFix(ArmyManager.instance.thane,_currentItem.data.templateInfo,false))
         {
            _loc2_ = LanguageMgr.GetTranslation("cell.view.GoodsItemMenu.command01");
            MessageTipManager.instance().show(_loc2_);
            dispose();
            return;
         }
         if(!BagHelper.instance.checkCanMulUse(_currentItem.data) || !check())
         {
            dispose();
            return;
         }
         if(_currentItem.data.templateInfo.SonType == 298)
         {
            FrameControllerManager.instance.openControllerByInfo("gradebox",null,_currentItem.data);
            return;
         }
         if(_currentItem.data.templateInfo.SonType == 222)
         {
            FrameControllerManager.instance.openControllerByInfo("newyearact",NewYearActController.HANDLSEL,_currentItem.data);
         }
         else if(_currentItem.data.templateInfo.SonType == 311)
         {
            switch(_currentItem.data.templateInfo.Property2)
            {
               case -800:
                  if(thane.gloryPoint < _currentItem.data.templateInfo.Property3)
                  {
                     _loc2_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command08");
                     MessageTipManager.instance().show(_loc2_);
                     return;
                  }
                  break;
               case -700:
                  if(playerInfo.strategy < _currentItem.data.templateInfo.Property3)
                  {
                     _loc2_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command08");
                     MessageTipManager.instance().show(_loc2_);
                     return;
                  }
                  break;
               case -600:
                  if(ResourceManager.instance.waterCrystal.count < _currentItem.data.templateInfo.Property3)
                  {
                     _loc2_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command08");
                     MessageTipManager.instance().show(_loc2_);
                     return;
                  }
                  break;
               case -500:
                  if(playerInfo.giftToken < _currentItem.data.templateInfo.Property3)
                  {
                     _loc2_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command08");
                     MessageTipManager.instance().show(_loc2_);
                     return;
                  }
                  break;
               case -400:
                  if(playerInfo.point < _currentItem.data.templateInfo.Property3)
                  {
                     _loc2_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command08");
                     MessageTipManager.instance().show(_loc2_);
                     return;
                  }
                  break;
               case -300:
                  if(playerInfo.strategy < _currentItem.data.templateInfo.Property3)
                  {
                     _loc2_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command08");
                     MessageTipManager.instance().show(_loc2_);
                     return;
                  }
                  break;
               case -200:
                  if(playerInfo.mineral < _currentItem.data.templateInfo.Property3)
                  {
                     _loc2_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command08");
                     MessageTipManager.instance().show(_loc2_);
                     return;
                  }
                  break;
               case -100:
                  if(ResourceManager.instance.gold.count < _currentItem.data.templateInfo.Property3)
                  {
                     _loc2_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command08");
                     MessageTipManager.instance().show(_loc2_);
                     return;
                  }
                  break;
               default:
                  if(GoodsManager.instance.getGoodsNumByTempId(_currentItem.data.templateInfo.Property2) < _currentItem.data.templateInfo.Property3)
                  {
                     _loc2_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command08");
                     MessageTipManager.instance().show(_loc2_);
                     return;
                  }
            }
         }
         var _loc3_:MulItemUseFrame = ComponentFactory.Instance.creatComponentByStylename("core.MulItemUseFrame");
         _loc3_.data = _currentItem;
         dispose();
         _loc3_.show();
      }
      
      private function __userHandler(param1:MouseEvent) : void
      {
         var _loc8_:String = null;
         var _loc19_:GoodsTemplateInfo = null;
         var _loc9_:MountTemplate = null;
         var _loc17_:ConfigInfosTempInfo = null;
         var _loc20_:int = 0;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc5_:String = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc12_:int = 0;
         var _loc2_:AppellInfoTemplate = null;
         var _loc18_:AppellModel = null;
         var _loc6_:int = 0;
         var _loc13_:Boolean = false;
         var _loc14_:PlayerBufferInfo = null;
         var _loc16_:int = 0;
         var _loc15_:int = 0;
         var _loc7_:int = 0;
         if(_currentItem && _currentItem.data)
         {
            if(_currentItem.data.templateInfo.SonType != 298 && !GoodsCheck.isGradeFix(ArmyManager.instance.thane,_currentItem.data.templateInfo,false))
            {
               _loc8_ = LanguageMgr.GetTranslation("cell.view.GoodsItemMenu.command01");
               MessageTipManager.instance().show(_loc8_);
               dispose();
               return;
            }
            if(_currentItem.data.templateInfo.SonType == 209)
            {
               SocketSendManager.instance.sendUseItem(_currentItem.data.pos);
            }
            else if(_currentItem.data.templateInfo.SonType == 201 || _currentItem.data.templateInfo.SonType == 237)
            {
               SocketSendManager.instance.sendUseItem(_currentItem.data.pos);
            }
            else if(_currentItem.data.templateInfo.SonType == 219)
            {
               SwitchPageHelp.openPumpingJoyFrame();
            }
            else if(_currentItem.data.templateInfo.SonType == 320)
            {
               if(_currentItem.data.randomSkill5 == 1)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.outDateGoods"));
                  return;
               }
               TreasureMapManager.instance.useTreasureMap(_currentItem.data);
            }
            else
            {
               if(_currentItem.data.templateInfo.SonType == 298)
               {
                  FrameControllerManager.instance.openControllerByInfo("gradebox",null,_currentItem.data);
                  return;
               }
               if(_currentItem.data.templateInfo.SonType == 222)
               {
                  FrameControllerManager.instance.openControllerByInfo("newyearact",NewYearActController.HANDLSEL,_currentItem.data);
               }
               else if(_currentItem.data.templateInfo.SonType == 278)
               {
                  fashionModel.selectedPanel = "FASHION_PANEL";
                  fashionModel.dispatchEvent(new FashionEvent("SWITCH_EQUIPVIEW",null));
                  FrameControllerManager.instance.openControllerByInfo("fashion",0);
               }
               else if(_currentItem.data.templateInfo.SonType == 622)
               {
                  if(SceneManager.instance.currentType != "OUTER_CITY_SCENE")
                  {
                     _loc8_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command11");
                     MessageTipManager.instance().show(_loc8_);
                  }
                  else
                  {
                     SocketSendManager.instance.sendUseItem(_currentItem.data.pos);
                  }
               }
               else if(_currentItem.data.templateInfo.SonType == 710)
               {
                  SocketSendManager.instance.sendUseStelaItem(_currentItem.data.pos);
               }
               else if(_currentItem.data.templateInfo.SonType == 311)
               {
                  switch(_currentItem.data.templateInfo.Property2)
                  {
                     case -800:
                        if(thane.gloryPoint < _currentItem.data.templateInfo.Property3)
                        {
                           _loc8_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command08");
                           MessageTipManager.instance().show(_loc8_);
                        }
                        else
                        {
                           checkForUseBox(_currentItem.data,1);
                        }
                        break;
                     case -700:
                        if(playerInfo.strategy < _currentItem.data.templateInfo.Property3)
                        {
                           _loc8_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command08");
                           MessageTipManager.instance().show(_loc8_);
                        }
                        else
                        {
                           checkForUseBox(_currentItem.data,1);
                        }
                        break;
                     case -600:
                        if(ResourceManager.instance.waterCrystal.count < _currentItem.data.templateInfo.Property3)
                        {
                           _loc8_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command08");
                           MessageTipManager.instance().show(_loc8_);
                        }
                        else
                        {
                           checkForUseBox(_currentItem.data,1);
                        }
                        break;
                     case -500:
                        if(playerInfo.giftToken < _currentItem.data.templateInfo.Property3)
                        {
                           _loc8_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command08");
                           MessageTipManager.instance().show(_loc8_);
                        }
                        else
                        {
                           checkForUseBox(_currentItem.data,1);
                        }
                        break;
                     case -400:
                        if(playerInfo.point < _currentItem.data.templateInfo.Property3)
                        {
                           _loc8_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command08");
                           MessageTipManager.instance().show(_loc8_);
                        }
                        else
                        {
                           checkForUseBox(_currentItem.data,1);
                        }
                        break;
                     case -300:
                        if(playerInfo.strategy < _currentItem.data.templateInfo.Property3)
                        {
                           _loc8_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command08");
                           MessageTipManager.instance().show(_loc8_);
                        }
                        else
                        {
                           checkForUseBox(_currentItem.data,1);
                        }
                        break;
                     case -200:
                        if(playerInfo.mineral < _currentItem.data.templateInfo.Property3)
                        {
                           _loc8_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command08");
                           MessageTipManager.instance().show(_loc8_);
                        }
                        else
                        {
                           checkForUseBox(_currentItem.data,1);
                        }
                        break;
                     case -100:
                        if(ResourceManager.instance.gold.count < _currentItem.data.templateInfo.Property3)
                        {
                           _loc8_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command08");
                           MessageTipManager.instance().show(_loc8_);
                        }
                        else
                        {
                           checkForUseBox(_currentItem.data,1);
                        }
                        break;
                     default:
                        if(GoodsManager.instance.getGoodsNumByTempId(_currentItem.data.templateInfo.Property2) < _currentItem.data.templateInfo.Property3)
                        {
                           _loc8_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command08");
                           MessageTipManager.instance().show(_loc8_);
                        }
                        else
                        {
                           checkForUseBox(_currentItem.data,1);
                        }
                  }
               }
               else
               {
                  if(_currentItem.data.templateInfo.SonType == 292)
                  {
                     if(MopupManager.instance.model.isMopup)
                     {
                        _loc8_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
                        MessageTipManager.instance().show(_loc8_);
                        return;
                     }
                     MaskUtils.instance.maskShow(0);
                     SocketSendManager.instance.sendUseVipMoney();
                     dispose();
                     return;
                  }
                  if(_currentItem.data.templateInfo.SonType == 217)
                  {
                     CheckUIModuleUtil.instance.tryCall("friends",openRosePresentCall,[_currentItem.data]);
                     dispose();
                     return;
                  }
                  if(_currentItem.data.templateInfo.SonType == 280)
                  {
                     CheckUIModuleUtil.instance.tryCall("core",openCrossBugleCall,[_currentItem.data]);
                     dispose();
                     return;
                  }
                  if(_currentItem.data.templateInfo.SonType == 399)
                  {
                     CheckUIModuleUtil.instance.tryCall("friends",openSnowRosePresentCall,[_currentItem.data]);
                     dispose();
                     return;
                  }
                  if(_currentItem.data.templateInfo.SonType == 289)
                  {
                     CheckUIModuleUtil.instance.tryCall("rename",openRenameCall,[_currentItem.data]);
                     dispose();
                     return;
                  }
                  if(_currentItem.data.templateInfo.SonType == 218)
                  {
                     _loc19_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_currentItem.data.templateId);
                     _loc9_ = TempleteManager.instance.mountTemplateDic[_loc19_.Property1];
                     _loc17_ = TempleteManager.instance.getConfigInfoByConfigName("mount_card_resolve_multiple");
                     _loc20_ = _loc9_.Power * parseInt(_loc17_.ConfigValue);
                     if(MountsManager.instance.avatarList.isLightTemplate(_loc19_.Property1))
                     {
                        if(_loc19_.Property2 != -1)
                        {
                           MountsManager.instance.sendUseGoods(_currentItem.data,false);
                        }
                        else
                        {
                           if(_loc19_.Refresh == -1)
                           {
                              MessageTipManager.instance().show(LanguageMgr.GetTranslation("cell.mediator.playerbag.useMountCardAlert2"));
                              return;
                           }
                           SimpleAlertHelper.instance.data = [__mountCardUserHandler,_currentItem.data];
                           _loc10_ = LanguageMgr.GetTranslation("public.confirm");
                           _loc11_ = LanguageMgr.GetTranslation("public.cancel");
                           _loc5_ = LanguageMgr.GetTranslation("public.prompt");
                           _loc3_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.useMountCardAlert",_loc20_);
                           SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc3_,_loc10_,_loc11_,true,true);
                        }
                     }
                     else
                     {
                        MountsManager.instance.sendUseGoods(_currentItem.data,true);
                     }
                  }
                  else if(_currentItem.data.templateInfo.SonType == 340)
                  {
                     SocketSendManager.instance.sendUseSexChangeCard(_currentItem.data.pos);
                  }
                  else if(_currentItem.data.templateInfo.SonType == 302)
                  {
                     FrameControllerManager.instance.armyController.startFrameByType(ArmyPanelEnum.SKILL_PANEL,1);
                  }
                  else if(_currentItem.data.templateInfo.SonType == 308)
                  {
                     checkForUsePetExpBook(_currentItem.data);
                  }
                  else if(_currentItem.data.templateInfo.SonType == 313)
                  {
                     checkForUsePetLandTransfer(_currentItem.data);
                  }
                  else if(_currentItem.data.templateInfo.SonType == 315)
                  {
                     if(thane.grades < 60)
                     {
                        _loc8_ = LanguageMgr.GetTranslation("singlepass.bugle.SinglePassBugleFrame.CannotUseTips",60);
                        MessageTipManager.instance().show(_loc8_);
                     }
                     else
                     {
                        FrameControllerManager.instance.openControllerByInfo("singlepass",2);
                     }
                  }
                  else if(_currentItem.data.templateId == 208044)
                  {
                     if(ChildManager.instance.model.applyInfo.state == 0)
                     {
                        ChildManager.instance.openSexFram(_currentItem.data.pos);
                     }
                     else
                     {
                        _loc8_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command10");
                        MessageTipManager.instance().show(_loc8_);
                     }
                  }
                  else if(_currentItem.data.templateInfo.SonType == 226)
                  {
                     ChildManager.instance.openFrame = 3;
                     ChildManager.instance.openChildFram();
                  }
                  else if(_currentItem.data.templateInfo.SonType == 624)
                  {
                     ChildManager.instance.openChildNsFram(1);
                  }
                  else if(_currentItem.data.templateInfo.TemplateId == 2032102)
                  {
                     useGroupfbIncomeAlert(_currentItem.data);
                  }
                  else if(_currentItem.data.templateInfo.SonType == 277)
                  {
                     ChildManager.instance.checkForExchangeChild();
                  }
                  else if(_currentItem.data.templateInfo.SonType == 800)
                  {
                     if(archaeologyModel.getGradeByExp(archaeologyModel.exp) < 3)
                     {
                        MessageTipManager.instance().show(LanguageMgr.GetTranslation("ArchaeologyMakeRightView.stargazingBtn.tipdata"));
                        return;
                     }
                     _loc4_ = 0;
                     if(_currentItem.data.templateInfo.TemplateId == 8001001 || _currentItem.data.templateInfo.TemplateId == 8001002)
                     {
                        _loc4_ = 0;
                     }
                     else if(_currentItem.data.templateInfo.TemplateId == 8001015)
                     {
                        _loc4_ = 1;
                     }
                     else if(_currentItem.data.templateInfo.TemplateId == 8001016 || _currentItem.data.templateInfo.TemplateId == 8001017)
                     {
                        _loc4_ = 2;
                     }
                     FrameControllerManager.instance.openControllerByInfo("stargazing",null,_loc4_);
                  }
                  else if(_currentItem.data.templateInfo.SonType == 801)
                  {
                     if(archaeologyModel.getGradeByExp(archaeologyModel.exp) < 3)
                     {
                        MessageTipManager.instance().show(LanguageMgr.GetTranslation("ArchaeologyMakeRightView.stargazingBtn.tipdata"));
                        return;
                     }
                     StarGazingManager.instance.model.selectStarIndex = _currentItem.data.templateInfo.Property1;
                     FrameControllerManager.instance.openControllerByInfo("stargazing",null,1);
                  }
                  else if(_currentItem.data.templateInfo.SonType == 221)
                  {
                     _loc12_ = _currentItem.data.templateInfo.Property1;
                     _loc18_ = FrameControllerManager.instance.appellControler.model;
                     if(_loc18_ && _loc18_.infos)
                     {
                        _loc2_ = _loc18_.infos[_loc12_];
                        if(_loc2_ && _loc2_.isGet && _loc2_.IsLong == 0)
                        {
                           _loc8_ = LanguageMgr.GetTranslation("cell.view.GoodsItemMenu.cannot.useAppellCard");
                           MessageTipManager.instance().show(_loc8_);
                           dispose();
                           return;
                        }
                     }
                     SocketSendManager.instance.sendUseItem(_currentItem.data.pos);
                  }
                  else if(_currentItem.data.templateInfo.SonType == 510)
                  {
                     _loc6_ = _currentItem.data.templateInfo.Property2;
                     _loc13_ = CampaignTemplateManager.instance.isOpenByActiveCampaign(_loc6_);
                     if(!_loc13_)
                     {
                        MessageTipManager.instance().show(LanguageMgr.GetTranslation("campaign.Goods.AddNum.isOpen"));
                        dispose();
                        return;
                     }
                     SocketSendManager.instance.sendUseItem(_currentItem.data.pos);
                  }
                  else if(check())
                  {
                     _loc14_ = PlayerBufferManager.instance.getItemBufferInfo(_currentItem.data.templateInfo.Property1);
                     if(_loc14_)
                     {
                        if(_currentItem.data.templateInfo.Property3 < _loc14_.grade)
                        {
                           _loc8_ = LanguageMgr.GetTranslation("cell.view.GoodsItemMenu.command02");
                           MessageTipManager.instance().show(_loc8_);
                           dispose();
                           return;
                        }
                        SocketSendManager.instance.sendUseItem(_currentItem.data.pos);
                     }
                     else
                     {
                        if(_currentItem.data.templateInfo.Property1 == 5 && _currentItem.data.templateInfo.Property2 > 0)
                        {
                           _loc16_ = _currentItem.data.templateInfo.Property2;
                           _loc15_ = _currentItem.data.pos;
                           _loc7_ = 1;
                           if(!checkWearyCanGet(_loc16_,_loc15_,_loc7_))
                           {
                              dispose();
                              return;
                           }
                           if(!checkWearyTodayCanGet(_loc16_,_loc15_,_loc7_))
                           {
                              dispose();
                              return;
                           }
                        }
                        SocketSendManager.instance.sendUseItem(_currentItem.data.pos);
                     }
                  }
               }
            }
         }
         dispose();
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
      
      private function checkForUseBox(param1:GoodsInfo, param2:int) : void
      {
         SimpleAlertHelper.instance.data = [useBoxCallBack,param1,param2];
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc6_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1.templateInfo.Property2).TemplateName;
         var _loc7_:String = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command09",1,param1.templateInfo.TemplateName,1 * param1.templateInfo.Property3,_loc5_);
         SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc7_,_loc3_,_loc4_,true,true,true);
      }
      
      private function useBoxCallBack(param1:Boolean, param2:Boolean, param3:GoodsInfo, param4:int) : void
      {
         if(param1)
         {
            SocketSendManager.instance.sendUseItem(param3.pos,param4);
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
      
      private function openCrossBugleCall(param1:Array) : void
      {
         var _loc2_:CrossBugleFrame = ComponentFactory.Instance.creatComponentByStylename("core.CrossBugleFrame");
         _loc2_.setData(param1[0]);
         _loc2_.show();
      }
      
      private function openRenameCall(param1:Array) : void
      {
         var _loc2_:RenameView = new RenameView(1,null,param1[0]);
         _loc2_.show();
      }
      
      private function callBack(param1:Boolean, param2:int) : void
      {
         if(param1)
         {
            SocketSendManager.instance.sendUseItem(param2);
         }
      }
      
      private function check() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:String = "";
         var _loc3_:Boolean = ShopGoodsInfo.CONSORTIA_USE_ITEM.indexOf(_currentItem.data.templateInfo.Property1) != -1;
         if(_currentItem.data.templateInfo.SonType == 294 && (model.sysCurTimeBySecond - playerInfo.lastOutConsortia >= 86400 || !playerInfo.isAuto))
         {
            _loc1_ = LanguageMgr.GetTranslation("cell.view.GoodsItemMenu.command07");
            MessageTipManager.instance().show(_loc1_);
            return false;
         }
         if(_currentItem.data.templateInfo.SonType == 203 && _loc3_ && playerInfo.consortiaID == 0)
         {
            _loc1_ = LanguageMgr.GetTranslation("cell.view.GoodsItemMenu.command03");
            MessageTipManager.instance().show(_loc1_);
            dispose();
            return false;
         }
         if(_currentItem.data.templateInfo.SonType == 211 && playerInfo.composeList.indexOf(_currentItem.data.templateInfo.Property1) >= 0)
         {
            _loc1_ = LanguageMgr.GetTranslation("cell.view.GoodsItemMenu.command04");
            MessageTipManager.instance().show(_loc1_);
            return false;
         }
         if(_currentItem.data.templateInfo.SonType == 213)
         {
            if(MopupManager.instance.model.isMopup)
            {
               _loc1_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
               MessageTipManager.instance().show(_loc1_);
               return false;
            }
            if(rewardModel.baseRewardDic.getList().length >= 1)
            {
               _loc1_ = LanguageMgr.GetTranslation("cell.view.GoodsItemMenu.command05");
               MessageTipManager.instance().show(_loc1_);
               return false;
            }
            if(rewardModel.remainRewardCount <= 0)
            {
               _loc1_ = LanguageMgr.GetTranslation("cell.view.GoodsItemMenu.command06");
               MessageTipManager.instance().show(_loc1_);
               return false;
            }
         }
         if(_currentItem.data.templateInfo.SonType == 306)
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
      
      private function openSnowRosePresentCall(param1:Array) : void
      {
         var _loc2_:SnowRosePresentView = ComponentFactory.Instance.creatComponentByStylename("friends.SnowRosePresentView");
         _loc2_.setData(param1[0]);
         _loc2_.show();
      }
      
      private function get rewardModel() : OfferRewardModel
      {
         return OfferRewardManager.instance.model;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get model() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function get fashionModel() : FashionModel
      {
         return FrameControllerManager.instance.fashionCodeController.model;
      }
      
      private function get archaeologyModel() : ArchaeologyModel
      {
         return ArchaeologyManager.instance.model;
      }
      
      public function dispose() : void
      {
         _currentItem = null;
         removeEvent();
         StageReferance.stage.focus = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         ObjectUtils.disposeObject(_currentItem);
         _currentItem = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_useBtn);
         _useBtn = null;
         ObjectUtils.disposeObject(_moveBtn);
         _moveBtn = null;
         ObjectUtils.disposeObject(_mulBtn);
         _mulBtn = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
      }
   }
}

