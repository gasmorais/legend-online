package armyII.viewII.information
{
   import bag.events.BagEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.controler.BuildingControler;
   import mvc.module.buildings.BuildInfo;
   import mvc.module.consortia.ConsortiaInfo;
   import mvc.module.currency.CurrencyInfo;
   import mvc.module.currency.CurrencyType;
   import yishi.SwitchPageHelp;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.BuildingManager;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GodsEveningManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   import yishi.view.tips.MessageTipManager;
   
   public class GoodsExchangeItem extends Component
   {
      
      private var _data:CurrencyInfo;
      
      private var _currencyNameTxt:FilterFrameText;
      
      private var _currencyNumTxt:FilterFrameText;
      
      private var _currencyTimeTxt:FilterFrameText;
      
      private var _currencyShopBtn:TextButton;
      
      private var _noContentTxt:FilterFrameText;
      
      private var _line:Bitmap;
      
      public function GoodsExchangeItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _currencyNameTxt = ComponentFactory.Instance.creatComponentByStylename("army.goodsExchengeItem.name");
         _currencyNumTxt = ComponentFactory.Instance.creatComponentByStylename("army.goodsExchengeItem.num");
         _currencyTimeTxt = ComponentFactory.Instance.creatComponentByStylename("army.goodsExchengeItem.time");
         _currencyShopBtn = ComponentFactory.Instance.creatComponentByStylename("army.goodsExchengeItem.gotoShopBtn");
         _line = ComponentFactory.Instance.creatBitmap("asset.army.line");
         addChild(_currencyNameTxt);
         _currencyNameTxt.text = "物品名称";
         addChild(_currencyNumTxt);
         _currencyNumTxt.text = "2000/20000";
         addChild(_currencyTimeTxt);
         _currencyTimeTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.timeStr01");
         addChild(_currencyShopBtn);
         _currencyShopBtn.text = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.gotoShopping");
         addChild(_line);
      }
      
      public function set data(param1:CurrencyInfo) : void
      {
         var _loc4_:Date = null;
         var _loc3_:Object = null;
         var _loc5_:String = null;
         var _loc2_:String = null;
         if(!param1)
         {
            _currencyNameTxt.text = "";
            _currencyNumTxt.text = "";
            _currencyTimeTxt.text = "";
            _currencyShopBtn.visible = false;
            if(_noContentTxt)
            {
               _noContentTxt.visible = false;
            }
            return;
         }
         _data = param1;
         _currencyNameTxt.text = CurrencyType.getCurrencyNameByType(_data.masterType);
         _currencyNameTxt.y = 6 - (_currencyNameTxt.numLines - 1) * 10;
         if(_data.masterType == 103)
         {
            if(!_noContentTxt)
            {
               _noContentTxt = ComponentFactory.Instance.creatComponentByStylename("army.goodsExchengeItem.name");
               addChild(_noContentTxt);
            }
            _noContentTxt.visible = true;
            _noContentTxt.text = LanguageMgr.GetTranslation("public.defaultnumber");
            _noContentTxt.x = _currencyShopBtn.x;
            _currencyShopBtn.text = "";
            _currencyShopBtn.visible = false;
         }
         else
         {
            if(_noContentTxt)
            {
               _noContentTxt.visible = false;
            }
            _currencyShopBtn.text = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.gotoShopping");
            _currencyShopBtn.visible = true;
         }
         if(_data.masterType == 27)
         {
            _currencyShopBtn.text = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.gotoPeiYang");
         }
         _currencyNumTxt.text = _data.amount + "";
         if(_data.masterType == -3)
         {
            _currencyNumTxt.text = _data.amount + "/99999";
         }
         if(_data.expiredDate == "2000-01-01 00:00:00" || _data.expiredDate == "")
         {
            if(_data.masterType == 46 || _data.masterType == 39)
            {
               _currencyTimeTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.timeStr02");
            }
            else
            {
               _currencyTimeTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.timeStr01");
            }
         }
         else
         {
            _loc4_ = DateFormatter.parse(_data.expiredDate,"YYYY-MM-DD hh:mm:ss");
            _loc3_ = DateFormatter.compareDate(_loc4_,playerModel.sysCurtime);
            if(!_loc3_["flag"])
            {
               _loc5_ = _loc4_.month + 1 >= 10 ? _loc4_.month + 1 + "" : "0" + (_loc4_.month + 1);
               _loc2_ = _loc4_.date >= 10 ? _loc4_.date + "" : "0" + _loc4_.date;
               _currencyTimeTxt.text = _loc4_.fullYear + "-" + _loc5_ + "-" + _loc2_;
            }
            else
            {
               _currencyTimeTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.timeStr02");
            }
         }
      }
      
      private function initEvent() : void
      {
         _currencyShopBtn.addEventListener("click",__currencyShopBtnHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__updateNum);
      }
      
      private function removeEvent() : void
      {
         _currencyShopBtn.removeEventListener("click",__currencyShopBtnHandler);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__updateNum);
      }
      
      private function __updateNum(param1:BagEvent) : void
      {
         if(_data && _data.masterType == 102)
         {
            _currencyNumTxt.text = PlayerManager.instance.currentPlayerModel.playerInfo.pokerScore.toString();
         }
      }
      
      private function __currencyShopBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:BuildInfo = null;
         FrameControllerManager.instance.shopController.setPreFrame("army",null);
         ArmyManager.instance.openCurrPage = this.parent.parent["currPage"];
         if(_currencyTimeTxt.text != LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.timeStr02"))
         {
            _loc2_ = "";
            switch(_data.masterType)
            {
               case 1:
                  if(thane.grades >= 50)
                  {
                     FrameControllerManager.instance.openControllerByInfo("shop",888,{"type":0});
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.pet_crystalPrompt",50);
                  }
                  break;
               case 26:
                  if(thane.grades >= 50)
                  {
                     FrameControllerManager.instance.openControllerByInfo("shop",888,{"type":2});
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.pet_creamPrompt",50);
                  }
                  break;
               case 100:
                  if(thane.grades >= 50)
                  {
                     FrameControllerManager.instance.openControllerByInfo("shop",888,{"type":1});
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.pet_spirit",50);
                  }
                  break;
               case 99:
                  if(thane.grades >= 50)
                  {
                     FrameControllerManager.instance.openControllerByInfo("shop",888,{"type":3});
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.pet_breath",50);
                  }
                  break;
               case 2:
                  if(thane.grades >= 50)
                  {
                     FrameControllerManager.instance.openControllerByInfo("shop",888);
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.pet_creamPrompt",50);
                  }
                  break;
               case 3:
                  if(thane.grades >= 50)
                  {
                     FrameControllerManager.instance.openControllerByInfo("shop",888);
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.pet_creamPrompt",50);
                  }
                  break;
               case 4:
                  if(thane.grades >= 50)
                  {
                     FrameControllerManager.instance.openControllerByInfo("shop",888);
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.pet_creamPrompt",50);
                  }
                  break;
               case 5:
                  if(thane.grades >= 50)
                  {
                     FrameControllerManager.instance.openControllerByInfo("shop",888);
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.pet_creamPrompt",50);
                  }
                  break;
               case 6:
                  if(thane.grades < 13)
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.guild_skillPrompt_1",13);
                  }
                  else if(playerModel.playerInfo.consortiaID <= 0)
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.guild_skillPrompt_2");
                  }
                  else if(consortiaInfo.shopLevel <= 0)
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.guild_skillPrompt_3");
                  }
                  else
                  {
                     FrameControllerManager.instance.openControllerByInfo("shop",2,{"type":1});
                  }
                  break;
               case 23:
                  if(thane.grades < 13)
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.guild_skillPrompt_1",13);
                  }
                  else if(playerModel.playerInfo.consortiaID <= 0)
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.guild_skillPrompt_2");
                  }
                  else if(consortiaInfo.shopLevel <= 0)
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.guild_skillPrompt_3");
                  }
                  else
                  {
                     FrameControllerManager.instance.openControllerByInfo("shop",2,{"type":2});
                  }
                  break;
               case 8:
                  if(thane.grades >= 16)
                  {
                     FrameControllerManager.instance.openControllerByInfo("shop",3);
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.arena_medalPrompt",16);
                  }
                  break;
               case -1:
                  if(thane.grades >= 18)
                  {
                     FrameControllerManager.instance.openControllerByInfo("shop",101);
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.starscorePrompt",18);
                  }
                  break;
               case -2:
                  if(thane.grades >= 18)
                  {
                     _loc3_ = BuildingManager.instance.getBuildingInfoBySonType(501);
                     FrameControllerManager.instance.openControllerByInfo(BuildingControler.getModelNameByInfo(_loc3_),null,_loc3_);
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.lightscorePrompt",18);
                  }
                  break;
               case -3:
                  if(thane.grades >= 25)
                  {
                     FrameControllerManager.instance.openControllerByInfo("shop",11);
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.purplecrystalPrompt",25);
                  }
                  break;
               case -4:
                  if(thane.grades >= 26)
                  {
                     FrameControllerManager.instance.openControllerByInfo("outercityshop");
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.shopscorePrompt",26);
                  }
                  break;
               case -5:
                  if(thane.grades >= 16)
                  {
                     FrameControllerManager.instance.openControllerByInfo("shop",3,{"type":3});
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.leaguescorePrompt",16);
                  }
                  break;
               case 10:
                  if(thane.grades >= 50)
                  {
                     FrameControllerManager.instance.openControllerByInfo("shop",19);
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.kingsealPrompt",13);
                  }
                  break;
               case 11:
                  if(thane.grades >= 11)
                  {
                     FrameControllerManager.instance.openControllerByInfo("shop",4);
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.mazeshop",11);
                  }
                  break;
               case 12:
                  if(thane.grades >= 36)
                  {
                     FrameControllerManager.instance.openControllerByInfo("shop",20);
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.matelordsPrompt",36);
                  }
                  break;
               case 14:
                  if(thane.grades >= 16)
                  {
                     FrameControllerManager.instance.openControllerByInfo("shop",1002);
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.mountShopPrompt",16);
                  }
                  break;
               case 102:
                  if(thane.grades >= 6)
                  {
                     FrameControllerManager.instance.openControllerByInfo("shop",1003);
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.mountShopPrompt",6);
                  }
                  break;
               case 103:
                  if(thane.grades < 6)
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.mountShopPrompt",6);
                  }
                  break;
               case 17:
                  if(thane.grades >= 13)
                  {
                     FrameControllerManager.instance.openControllerByInfo("shop",1004);
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.mountShopPrompt",13);
                  }
                  break;
               case 101:
                  if(thane.grades >= 80)
                  {
                     FrameControllerManager.instance.openControllerByInfo("shop",9001);
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.navigationShopPrompt",80);
                  }
                  break;
               case 18:
                  if(thane.grades >= 36)
                  {
                     FrameControllerManager.instance.openControllerByInfo("shop",10);
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.areslordsShopPrompt",36);
                  }
                  break;
               case 19:
                  if(thane.grades >= 13)
                  {
                     FrameControllerManager.instance.openControllerByInfo("shop",13);
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.yarramanPrompt",13);
                  }
                  break;
               case 20:
                  if(thane.grades >= 40)
                  {
                     FrameControllerManager.instance.openControllerByInfo("shop",16);
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.bravelegShopPrompt",40);
                  }
                  break;
               case 22:
                  if(thane.grades >= 15)
                  {
                     FrameControllerManager.instance.openControllerByInfo("shop",1008);
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.gloryShopPrompt",15);
                  }
                  break;
               case 27:
                  if(thane.vocationGrades > 0)
                  {
                     FrameControllerManager.instance.openControllerByInfo("star",5);
                     FrameControllerManager.instance.starController.setPreFrame("star",null);
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.subStarPrompt");
                  }
                  break;
               case 21:
                  if(thane.grades >= 11)
                  {
                     FrameControllerManager.instance.openControllerByInfo("shop",1005,{"type":1});
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.bingoShopPrompt",11);
                  }
                  break;
               case 24:
                  if(thane.grades >= 10)
                  {
                     FrameControllerManager.instance.openControllerByInfo("shop",1010);
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.exploreShopPrompt",10);
                  }
                  break;
               case 28:
                  if(thane.grades >= 80)
                  {
                     FrameControllerManager.instance.openControllerByInfo("shop",1011);
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.assaultwarShopPrompt",80);
                  }
                  break;
               case 46:
                  if(!GodsEveningManager.instance.model.isShowIcon)
                  {
                     MessageTipManager.instance().show(LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.GodsMarking"));
                  }
                  else
                  {
                     FrameControllerManager.instance.openControllerByInfo("shop",35);
                  }
                  break;
               case 29:
                  if(thane.grades < 13)
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.guild_skillPrompt_1",13);
                  }
                  else if(playerModel.playerInfo.consortiaID <= 0)
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.guild_skillPrompt_2");
                  }
                  else if(consortiaInfo.shopLevel <= 0)
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.guild_skillPrompt_3");
                  }
                  else
                  {
                     FrameControllerManager.instance.openControllerByInfo("shop",2,{"type":3});
                  }
                  break;
               case 31:
                  if(thane.grades >= 13)
                  {
                     if(playerModel.playerInfo.consortiaID <= 0)
                     {
                        _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.guild_skillPrompt_2");
                     }
                     else if(ConsortiaManager.instance.model.consortiaInfo.shopLevel > 0)
                     {
                        FrameControllerManager.instance.openControllerByInfo("shop",2,{"type":4});
                     }
                     else
                     {
                        FrameControllerManager.instance.openControllerByInfo("shop",2,{"type":0});
                     }
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("information.GoodsExchangeItem.newCrossGuild.alert",13);
                  }
                  break;
               case 30:
                  if(thane.grades >= 80)
                  {
                     FrameControllerManager.instance.openControllerByInfo("shop",1015);
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("information.GoodsExchangeItem.apex.alert",80);
                  }
                  break;
               case 32:
                  if(thane.grades >= 1)
                  {
                     FrameControllerManager.instance.openControllerByInfo("shop",1017);
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("information.GoodsExchangeItem.apex.alert",1);
                  }
                  break;
               case 33:
                  if(thane.vocationGrades > 0)
                  {
                     FrameControllerManager.instance.openControllerByInfo("shop",1018);
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.subStarPrompt");
                  }
                  break;
               case 34:
                  if(thane.vocationGrades > 0)
                  {
                     FrameControllerManager.instance.openControllerByInfo("shop",1018,{"type":1});
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.subStarPrompt");
                  }
                  break;
               case 37:
                  if(thane.isChangeJob)
                  {
                     FrameControllerManager.instance.openControllerByInfo("shop",1020,{"type":1});
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.flameTemplePrompt");
                  }
                  break;
               case 38:
                  if(thane.isAvenger)
                  {
                     FrameControllerManager.instance.openControllerByInfo("shop",1021,{"type":2});
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.duskAreaPrompt");
                  }
                  break;
               case 39:
                  SwitchPageHelp.openDarkMazeShopFrame();
                  break;
               case 58:
                  SwitchPageHelp.openPoseidonFrame();
                  break;
               case 61:
                  if(thane.isAvenger)
                  {
                     FrameControllerManager.instance.openControllerByInfo("secretwar",5);
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("SecretwarEnterFrame.open.text");
                  }
            }
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.prompt");
         }
         if(_loc2_ != "")
         {
            MessageTipManager.instance().show(_loc2_);
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get consortiaInfo() : ConsortiaInfo
      {
         return FrameControllerManager.instance.consortiaController.model.consortiaInfo;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_noContentTxt)
         {
            ObjectUtils.disposeObject(_noContentTxt);
         }
         ObjectUtils.disposeObject(_currencyNameTxt);
         ObjectUtils.disposeObject(_currencyNumTxt);
         ObjectUtils.disposeObject(_currencyTimeTxt);
         ObjectUtils.disposeObject(_currencyShopBtn);
         ObjectUtils.disposeObject(_line);
      }
   }
}

