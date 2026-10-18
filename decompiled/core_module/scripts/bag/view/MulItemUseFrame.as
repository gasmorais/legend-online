package bag.view
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import managers.MarryManager;
   import managers.MopupManager;
   import mvc.module.children.ChildSender;
   import mvc.module.pet.PetData;
   import simplegame.roses.RosePresentView;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerBufferInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.CampaignTemplateManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerBufferManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.ResourceManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.MaskUtils;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class MulItemUseFrame extends SpliteItemFrame
   {
      
      public var _isItem:Boolean = true;
      
      public function MulItemUseFrame()
      {
         super();
         titleText = LanguageMgr.GetTranslation("bag.view.MulItemUseFrame.command01");
      }
      
      override public function set data(param1:*) : void
      {
         var _loc4_:int = 0;
         var _loc2_:GoodsTemplateInfo = null;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         if(_isItem)
         {
            isItem = true;
            _item = param1;
            _numberText.text = param1.data.count.toString();
            if(_item.data.templateInfo.SonType == 311)
            {
               switch(_item.data.templateInfo.Property2)
               {
                  case -800:
                     _loc4_ = thane.gloryPoint / _item.data.templateInfo.Property3;
                     break;
                  case -700:
                     _loc4_ = playerInfo.strategy / _item.data.templateInfo.Property3;
                     break;
                  case -600:
                     _loc4_ = ResourceManager.instance.waterCrystal.count / _item.data.templateInfo.Property3;
                     break;
                  case -500:
                     _loc4_ = playerInfo.giftToken / _item.data.templateInfo.Property3;
                     break;
                  case -400:
                     _loc4_ = playerInfo.point / _item.data.templateInfo.Property3;
                     break;
                  case -300:
                     _loc4_ = playerInfo.strategy / _item.data.templateInfo.Property3;
                     break;
                  case -200:
                     _loc4_ = playerInfo.mineral / _item.data.templateInfo.Property3;
                     break;
                  case -100:
                     _loc4_ = ResourceManager.instance.gold.count / _item.data.templateInfo.Property3;
                     break;
                  default:
                     _loc4_ = GoodsManager.instance.getGoodsNumByTempId(_item.data.templateInfo.Property2) / _item.data.templateInfo.Property3;
               }
               _numberText.text = Math.min(param1.data.count,_loc4_).toString();
            }
         }
         else
         {
            isItem = false;
            _goodsInfo = param1;
            _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_goodsInfo.templateId);
            _loc5_ = GoodsManager.instance.getGoodsNumByTempId(_goodsInfo.templateId);
            if(_loc2_.SonType == 226)
            {
               _loc3_ = _goodsInfo.count;
            }
            _numberText.text = Math.min(_loc3_,_loc5_).toString();
         }
      }
      
      private function __marryInfoHandler(param1:String, param2:Object) : void
      {
         if(MarryManager.instance.model.isSingle)
         {
            dispose();
         }
      }
      
      override protected function __confirmHandler(param1:MouseEvent) : void
      {
         var _loc9_:int = 0;
         var _loc4_:Boolean = false;
         var _loc5_:PlayerBufferInfo = null;
         var _loc2_:String = null;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc10_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:GoodsTemplateInfo = null;
         if(isItem)
         {
            if(!_item || !_item.data || int(_numberText.text) <= 0)
            {
               dispose();
               return;
            }
            if(_item.data.templateInfo.SonType == 209)
            {
               SocketSendManager.instance.sendUseItem(_item.data.pos,int(_numberText.text));
               dispose();
            }
            else if(_item.data.templateInfo.SonType == 710)
            {
               SocketSendManager.instance.sendUseStelaItem(_item.data.pos,int(_numberText.text));
               dispose();
            }
            else if(_item.data.templateInfo.SonType == 292)
            {
               if(MopupManager.instance.model.isMopup)
               {
                  _loc2_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
                  MessageTipManager.instance().show(_loc2_);
                  return;
               }
               MaskUtils.instance.maskShow(0);
               SocketSendManager.instance.sendUseVipMoney();
               dispose();
            }
            else if(_item.data.templateInfo.SonType == 217)
            {
               CheckUIModuleUtil.instance.tryCall("friends",openRosePresentCall,[_item.data,int(_numberText.text)]);
               dispose();
            }
            else if(_item.data.templateInfo.SonType == 308)
            {
               checkForUsePetExpBook(_item.data,int(_numberText.text));
               dispose();
            }
            else if(_item.data.templateInfo.SonType == 510)
            {
               _loc9_ = _item.data.templateInfo.Property2;
               _loc4_ = CampaignTemplateManager.instance.isOpenByActiveCampaign(_loc9_);
               if(!_loc4_)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("campaign.Goods.AddNum.isOpen"));
                  dispose();
                  return;
               }
               SocketSendManager.instance.sendUseItem(_item.data.pos,int(_numberText.text));
            }
            else if(_item.data.templateInfo.SonType == 311)
            {
               switch(_item.data.templateInfo.Property2)
               {
                  case -800:
                     if(thane.gloryPoint < _item.data.templateInfo.Property3 * parseInt(_numberText.text))
                     {
                        _loc2_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command08");
                        MessageTipManager.instance().show(_loc2_);
                     }
                     else
                     {
                        checkForUseBox(_item.data,parseInt(_numberText.text));
                     }
                     break;
                  case -700:
                     if(playerInfo.strategy < _item.data.templateInfo.Property3 * parseInt(_numberText.text))
                     {
                        _loc2_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command08");
                        MessageTipManager.instance().show(_loc2_);
                     }
                     else
                     {
                        checkForUseBox(_item.data,parseInt(_numberText.text));
                     }
                     break;
                  case -600:
                     if(ResourceManager.instance.waterCrystal.count < _item.data.templateInfo.Property3 * parseInt(_numberText.text))
                     {
                        _loc2_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command08");
                        MessageTipManager.instance().show(_loc2_);
                     }
                     else
                     {
                        checkForUseBox(_item.data,parseInt(_numberText.text));
                     }
                     break;
                  case -500:
                     if(playerInfo.giftToken < _item.data.templateInfo.Property3 * parseInt(_numberText.text))
                     {
                        _loc2_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command08");
                        MessageTipManager.instance().show(_loc2_);
                     }
                     else
                     {
                        checkForUseBox(_item.data,parseInt(_numberText.text));
                     }
                     break;
                  case -400:
                     if(playerInfo.point < _item.data.templateInfo.Property3 * parseInt(_numberText.text))
                     {
                        _loc2_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command08");
                        MessageTipManager.instance().show(_loc2_);
                     }
                     else
                     {
                        checkForUseBox(_item.data,parseInt(_numberText.text));
                     }
                     break;
                  case -300:
                     if(playerInfo.strategy < _item.data.templateInfo.Property3 * parseInt(_numberText.text))
                     {
                        _loc2_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command08");
                        MessageTipManager.instance().show(_loc2_);
                     }
                     else
                     {
                        checkForUseBox(_item.data,parseInt(_numberText.text));
                     }
                     break;
                  case -200:
                     if(playerInfo.mineral < _item.data.templateInfo.Property3 * parseInt(_numberText.text))
                     {
                        _loc2_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command08");
                        MessageTipManager.instance().show(_loc2_);
                     }
                     else
                     {
                        checkForUseBox(_item.data,parseInt(_numberText.text));
                     }
                     break;
                  case -100:
                     if(ResourceManager.instance.gold.count < _item.data.templateInfo.Property3 * parseInt(_numberText.text))
                     {
                        _loc2_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command08");
                        MessageTipManager.instance().show(_loc2_);
                     }
                     else
                     {
                        checkForUseBox(_item.data,parseInt(_numberText.text));
                     }
                     break;
                  default:
                     if(GoodsManager.instance.getGoodsNumByTempId(_item.data.templateInfo.Property2) < _item.data.templateInfo.Property3 * parseInt(_numberText.text))
                     {
                        _loc2_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command08");
                        MessageTipManager.instance().show(_loc2_);
                     }
                     else
                     {
                        checkForUseBox(_item.data,parseInt(_numberText.text));
                     }
               }
               dispose();
            }
            else if(check())
            {
               _loc5_ = PlayerBufferManager.instance.getItemBufferInfo(_item.data.templateInfo.Property1);
               if(_loc5_)
               {
                  if(_item.data.templateInfo.Property3 < _loc5_.grade)
                  {
                     _loc2_ = LanguageMgr.GetTranslation("bag.view.MulItemUseFrame.command02");
                     MessageTipManager.instance().show(_loc2_);
                     dispose();
                     return;
                  }
                  SocketSendManager.instance.sendUseItem(_item.data.pos,int(_numberText.text));
               }
               else
               {
                  if(_item.data.templateInfo.Property1 == 5 && _item.data.templateInfo.Property2 > 0)
                  {
                     _loc8_ = _item.data.templateInfo.Property2 * int(_numberText.text);
                     _loc6_ = _item.data.pos;
                     _loc10_ = int(_numberText.text);
                     if(!checkWearyCanGet(_loc8_,_loc6_,_loc10_))
                     {
                        dispose();
                        return;
                     }
                     if(!checkWearyTodayCanGet(_loc8_,_loc6_,_loc10_))
                     {
                        dispose();
                        return;
                     }
                  }
                  SocketSendManager.instance.sendUseItem(_item.data.pos,int(_numberText.text));
               }
               dispose();
            }
         }
         else
         {
            _loc7_ = int(_numberText.text);
            _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_goodsInfo.templateId);
            if(_goodsInfo.templateId == 208042)
            {
               if(ChildManager.instance.curSelectChild && ChildManager.instance.curSelectChild.state != -1)
               {
                  ChildSender.useResetGoods(ChildManager.instance.curSelectChild.childId,_loc7_);
               }
               else
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.handin.ChildHandInFrame.noThisChild"));
               }
            }
            else if(_goodsInfo.templateInfo.SonType == 226)
            {
               if(ChildManager.instance.curSelectChild && ChildManager.instance.curSelectChild.state != -1)
               {
                  ChildSender.upgradeSkill(ChildManager.instance.curSelectChild.childId,_goodsInfo.randomSkill1,_loc7_);
               }
               else
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.handin.ChildHandInFrame.noThisChild"));
               }
            }
            dispose();
         }
      }
      
      private function checkForUseBox(param1:GoodsInfo, param2:int) : void
      {
         SimpleAlertHelper.instance.data = [useBoxCallBack,param1,param2];
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc6_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1.templateInfo.Property2).TemplateName;
         var _loc7_:String = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command09",param2,param1.templateInfo.TemplateName,param2 * param1.templateInfo.Property3,_loc5_);
         SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc7_,_loc3_,_loc4_,true,true,true);
      }
      
      private function useBoxCallBack(param1:Boolean, param2:Boolean, param3:GoodsInfo, param4:int) : void
      {
         if(param1)
         {
            SocketSendManager.instance.sendUseItem(param3.pos,param4);
         }
      }
      
      private function checkForUsePetExpBook(param1:GoodsInfo, param2:int) : void
      {
         var _loc6_:Number = param1.templateInfo.Property2 * param2;
         SimpleAlertHelper.instance.data = [checkForUsePetExpBookBack,param1,param2];
         var _loc5_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc7_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("checkForUsePetExpBook.content02",_loc6_);
         SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc4_,_loc5_,_loc3_,true,true,true);
      }
      
      private function checkForUsePetExpBookBack(param1:Boolean, param2:Boolean, param3:GoodsInfo, param4:int) : void
      {
         var _loc5_:String = null;
         if(!param1)
         {
            return;
         }
         if(!param3)
         {
            return;
         }
         var _loc6_:PetData = playerInfo.enterWarPet;
         if(!_loc6_)
         {
            _loc5_ = LanguageMgr.GetTranslation("checkForUsePetExpBook.content01");
            MessageTipManager.instance().show(_loc5_);
            return;
         }
         if(_loc6_.isFullExp())
         {
            _loc5_ = LanguageMgr.GetTranslation("PetSwallowView.fullExp");
            MessageTipManager.instance().show(_loc5_);
            return;
         }
         SocketSendManager.instance.sendUseItem(param3.pos,param4);
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
         _loc2_.setData(param1[0],param1[1]);
         _loc2_.show();
      }
      
      private function callBack(param1:Boolean, param2:int) : void
      {
         if(param1)
         {
            SocketSendManager.instance.sendUseItem(_item.data.pos,int(_numberText.text));
            dispose();
         }
      }
      
      private function check() : Boolean
      {
         var _loc1_:String = null;
         if(_item.data.templateInfo.SonType == 203 && _item.data.templateInfo.Property1 == 8 && playerInfo.consortiaID == 0)
         {
            _loc1_ = LanguageMgr.GetTranslation("bag.view.MulItemUseFrame.command03");
            MessageTipManager.instance().show(_loc1_);
            dispose();
            return false;
         }
         return true;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         MsgMan.removeObserver("MarryEventType.SELF_MARRY_INFO",this,__marryInfoHandler);
      }
   }
}

