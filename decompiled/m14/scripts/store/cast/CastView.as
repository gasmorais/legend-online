package store.cast
{
   import bag.events.BagEvent;
   import bag.helper.GoodsCheck;
   import cell.view.storebag.StoreCastCell;
   import cell.view.storebag.StoreIntensifyCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.store.StoreRspMsg;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.controler.StoreControler;
   import yishi.comm.PackageIn;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.ResourceManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.SimpleDictionary;
   import yishi.utils.StoreHelper;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   import yishi.view.tips.goods.MouldItem;
   
   public class CastView extends Sprite implements Disposeable
   {
      
      private var _bg:MutipleImage;
      
      private var _successRatesImg:Image;
      
      private var _neededGoldImg:Image;
      
      private var _successRatesTxt:FilterFrameText;
      
      private var _neededGoldTxt:FilterFrameText;
      
      private var _blessBar:MovieImage;
      
      private var _blessTxt:FilterFrameText;
      
      private var _blessValueTxt:FilterFrameText;
      
      private var _castBtn:IconButton;
      
      private var _equip:StoreCastCell;
      
      private var _previewEquip:BaseItemView;
      
      private var _mate1:CastNeededMaterialItem;
      
      private var _mate2:CastNeededMaterialItem;
      
      private var _mouldItem1:MouldItem;
      
      private var _mouldItem2:MouldItem;
      
      private var _gradeMaxTip:Bitmap;
      
      private var _alertText:FilterFrameText;
      
      private var _itemDic:SimpleDictionary;
      
      private var _controller:StoreControler;
      
      public function CastView()
      {
         super();
         _controller = FrameControllerManager.instance.storeController;
         initView();
         initEvent();
         refreshView();
      }
      
      public function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("store.CastViewBg");
         _successRatesImg = ComponentFactory.Instance.creatComponentByStylename("store.CastSuccessRatesTxtImg");
         _neededGoldImg = ComponentFactory.Instance.creatComponentByStylename("store.CastNeededGoldTxtImg");
         _successRatesTxt = ComponentFactory.Instance.creatComponentByStylename("store.CastSuccessRatesTxt");
         _neededGoldTxt = ComponentFactory.Instance.creatComponentByStylename("store.CastNeededGoldTxt");
         _blessBar = ComponentFactory.Instance.creatComponentByStylename("store.CastBlessingBar");
         _blessTxt = ComponentFactory.Instance.creatComponentByStylename("store.CastBlessingTxt");
         _blessValueTxt = ComponentFactory.Instance.creatComponentByStylename("store.CastBlessingValueTxt");
         _castBtn = ComponentFactory.Instance.creatComponentByStylename("store.CastEquipBtn");
         _equip = ComponentFactory.Instance.creatCustomObject("store.CastEquipItem");
         _previewEquip = ComponentFactory.Instance.creatCustomObject("store.CastPreviewEquipItem");
         _mate1 = ComponentFactory.Instance.creatCustomObject("store.CastNeededMaterialItem1");
         _mate2 = ComponentFactory.Instance.creatCustomObject("store.CastNeededMaterialItem2");
         _mouldItem1 = ComponentFactory.Instance.creatCustomObject("store.CastMouldItem1");
         _mouldItem2 = ComponentFactory.Instance.creatCustomObject("store.CastMouldItem2");
         _gradeMaxTip = ComponentFactory.Instance.creatBitmap("asset.store.CastTipImg");
         _alertText = ComponentFactory.Instance.creatComponentByStylename("store.CastView.alertText");
         addChild(_bg);
         addChild(_neededGoldImg);
         addChild(_neededGoldTxt);
         addChild(_blessBar);
         addChild(_blessTxt);
         addChild(_blessValueTxt);
         addChild(_castBtn);
         addChild(_equip);
         addChild(_previewEquip);
         addChild(_mate1);
         addChild(_mate2);
         addChild(_mouldItem1);
         addChild(_mouldItem2);
         addChild(_gradeMaxTip);
         addChild(_alertText);
         _blessBar.tipData = LanguageMgr.GetTranslation("store.cast.CastView.BlessBarTips");
         _blessTxt.text = LanguageMgr.GetTranslation("store.cast.CastView.BlessTxt");
         _alertText.text = LanguageMgr.GetTranslation("store.CastView.alertText.text");
         _equip.sonType = -1;
         _itemDic = new SimpleDictionary(true);
         _itemDic.add("0_0_0",_equip);
      }
      
      public function uninitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_successRatesImg);
         _successRatesImg = null;
         ObjectUtils.disposeObject(_neededGoldImg);
         _neededGoldImg = null;
         ObjectUtils.disposeObject(_successRatesTxt);
         _successRatesTxt = null;
         ObjectUtils.disposeObject(_neededGoldTxt);
         _neededGoldTxt = null;
         ObjectUtils.disposeObject(_blessBar);
         _blessBar = null;
         ObjectUtils.disposeObject(_blessTxt);
         _blessTxt = null;
         ObjectUtils.disposeObject(_blessValueTxt);
         _blessValueTxt = null;
         ObjectUtils.disposeObject(_castBtn);
         _castBtn = null;
         ObjectUtils.disposeObject(_equip);
         _equip = null;
         ObjectUtils.disposeObject(_previewEquip);
         _previewEquip = null;
         ObjectUtils.disposeObject(_mate1);
         _mate1 = null;
         ObjectUtils.disposeObject(_mate2);
         _mate2 = null;
         ObjectUtils.disposeObject(_mouldItem1);
         _mouldItem1 = null;
         ObjectUtils.disposeObject(_mouldItem2);
         _mouldItem2 = null;
         ObjectUtils.disposeObject(_gradeMaxTip);
         _gradeMaxTip = null;
         ObjectUtils.disposeObject(_alertText);
         _alertText = null;
         ObjectUtils.disposeAllChildren(this);
         _itemDic = null;
      }
      
      private function initEvent() : void
      {
         _castBtn.addEventListener("click",__castBtnClickHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4558,__mouldResult);
      }
      
      private function removeEvent() : void
      {
         _castBtn.removeEventListener("click",__castBtnClickHandler);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemDeleteHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4558,__mouldResult);
      }
      
      private function __castBtnClickHandler(param1:MouseEvent) : void
      {
         mould();
      }
      
      private function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc4_:GoodsInfo = param1.info;
         var _loc2_:GoodsInfo = copyGoods(_loc4_);
         var _loc3_:BaseItemView = _itemDic[_loc4_.pos + "_" + _loc4_.objectId + "_" + _loc4_.bagType];
         if(_loc3_)
         {
            _loc3_.data = _loc4_;
            _loc2_.mouldGrade = _loc4_.MOULD_MAX_GRADE;
            _previewEquip.data = _loc2_;
            refreshView();
         }
      }
      
      private function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         var _loc2_:BaseItemView = _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_)
         {
            _loc2_.data = null;
            _previewEquip.data = null;
            refreshView();
         }
      }
      
      protected function __mouldResult(param1:SLGSocketEvent) : void
      {
         var _loc3_:String = null;
         var _loc6_:GoodsInfo = null;
         var _loc4_:StoreIntensifyCell = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:StoreRspMsg = new StoreRspMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as StoreRspMsg;
         if(_loc2_.strengResult)
         {
            _loc6_ = GoodsManager.instance.getHideBagItemByPos(_loc2_.pos);
            _loc6_.objectId = _loc2_.objectId;
            _loc6_.bagType = _loc2_.bagType;
            _loc6_.mouldGrade = _loc2_.strengthenGrade;
            _loc4_ = _itemDic[_loc6_.pos + "_" + _loc6_.objectId + "_" + _loc6_.bagType];
            if(_loc4_)
            {
               _loc4_.data = _loc6_;
            }
            _loc3_ = LanguageMgr.GetTranslation("store.cast.CastView.MouldTips01");
            MessageTipManager.instance().show(_loc3_);
         }
         else
         {
            _loc3_ = LanguageMgr.GetTranslation("store.cast.CastView.MouldTips02",5);
            MessageTipManager.instance().show(_loc3_);
         }
         refreshView();
      }
      
      private function mould() : void
      {
         var _loc8_:String = null;
         var _loc9_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(ResourceManager.instance.gold.count < int(StringHelper.trim(_neededGoldTxt.text)))
         {
            _loc8_ = LanguageMgr.GetTranslation("public.gold");
            MessageTipManager.instance().show(_loc8_);
            return;
         }
         if(playerInfo.vocationLevel < 8 && _equip.data.mouldRank == playerInfo.vocationLevel && _equip.data.mouldStar == 10 || playerInfo.vocationLevel == 8 && _equip.data.mouldRank == _equip.data.MOULD_MAX_RANK && _equip.data.mouldStar == 10)
         {
            _loc8_ = LanguageMgr.GetTranslation("store.cast.CastView.MouldTips03");
            MessageTipManager.instance().show(_loc8_);
            return;
         }
         var _loc1_:Array = [2120100,2120101,2120102,2120103,2120106,2120107];
         var _loc13_:GoodsInfo = _equip.data;
         var _loc3_:int = int(GoodsManager.instance.getGoodsNumByTempId(_loc13_.MOULD_NEED_MATERIAL1));
         var _loc2_:int = int(GoodsManager.instance.getGoodsNumByTempId(_loc13_.MOULD_NEED_MATERIAL2));
         var _loc10_:int = 5;
         var _loc4_:int = 15;
         var _loc12_:int = _loc1_.indexOf(_loc13_.MOULD_NEED_MATERIAL1);
         var _loc11_:int = _loc1_.indexOf(_loc13_.MOULD_NEED_MATERIAL2);
         if(_loc13_.templateInfo.SonType == 118 || _loc13_.templateInfo.SonType == 117)
         {
            if(_loc13_.mouldGrade >= 80)
            {
               _loc10_ = _loc13_.getMouldNeedCount(1) * 3;
               _loc4_ = _loc13_.getMouldNeedCount(2) * 3;
            }
            else
            {
               _loc10_ = 10;
               _loc4_ = 30;
            }
         }
         else
         {
            _loc10_ = int(_loc13_.getMouldNeedCount(1));
            _loc4_ = int(_loc13_.getMouldNeedCount(2));
         }
         if(_loc3_ < _loc10_ || _loc2_ < _loc4_)
         {
            if(_loc13_.mouldGrade >= 160)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("store.cast.mould.tips"));
               return;
            }
            _loc9_ = ConfigInfoManager.instance.getEquipAdvPoint();
            _loc5_ = (_loc10_ - _loc3_) * _loc9_[_loc12_];
            _loc5_ = int(_loc5_ < 0 ? 0 : _loc5_);
            _loc6_ = (_loc4_ - _loc2_) * _loc9_[_loc11_];
            _loc6_ = int(_loc6_ < 0 ? 0 : _loc6_);
            _loc7_ = _loc5_ + _loc6_;
            showPromptAlert(_loc7_);
            return;
         }
         _controller.sendItemMould();
      }
      
      private function showPromptAlert(param1:int) : void
      {
         SimpleAlertHelper.instance.data = [showPromptAlertBack,param1];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("store.cast.CastView.MouldTips04",param1);
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,true,false,2,"USEBINDPOINT_ALERT");
      }
      
      private function showPromptAlertBack(param1:Boolean, param2:Boolean, param3:int) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         if(param1)
         {
            _loc5_ = 0;
            if(param2)
            {
               _loc5_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint);
            }
            else
            {
               _loc5_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
            }
            if(_loc5_ < param3)
            {
               RechargeAlertMannager.show();
            }
            else
            {
               _loc4_ = param2 ? 0 : 1;
               _controller.sendItemMould(_loc4_);
            }
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function copyGoods(param1:GoodsInfo) : GoodsInfo
      {
         var _loc2_:GoodsInfo = new GoodsInfo();
         _loc2_.id = param1.id;
         _loc2_.pos = param1.pos;
         _loc2_.objectId = param1.objectId;
         _loc2_.templateId = param1.templateId;
         _loc2_.isBinds = param1.isBinds;
         _loc2_.validDate = param1.validDate;
         _loc2_.beginDate = param1.beginDate;
         _loc2_.strengthenGrade = param1.strengthenGrade;
         _loc2_.join1 = param1.join1;
         _loc2_.join2 = param1.join2;
         _loc2_.join3 = param1.join3;
         _loc2_.join4 = param1.join4;
         _loc2_.randomSkill1 = param1.randomSkill1;
         _loc2_.randomSkill2 = param1.randomSkill2;
         _loc2_.randomSkill3 = param1.randomSkill3;
         _loc2_.randomSkill4 = param1.randomSkill4;
         _loc2_.randomSkill5 = param1.randomSkill5;
         _loc2_.mouldGrade = param1.mouldGrade;
         _loc2_.blessValue = param1.blessValue;
         return _loc2_;
      }
      
      private function refreshView() : void
      {
         var _loc4_:* = 0;
         var _loc9_:GoodsInfo = _equip.data;
         var _loc7_:int = -1;
         var _loc5_:int = -1;
         var _loc2_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         _castBtn.enable = false;
         _gradeMaxTip.visible = false;
         _successRatesTxt.text = "--";
         _neededGoldTxt.text = "--";
         _blessTxt.visible = false;
         _blessValueTxt.visible = false;
         _blessBar.visible = false;
         if(_loc9_)
         {
            _castBtn.enable = true;
            if(_loc9_.mouldGrade < _loc9_.MOULD_MAX_GRADE)
            {
               _loc1_ = int(_loc9_.mouldGrade);
               _gradeMaxTip.visible = false;
               if(_loc9_.templateInfo.SonType == 118 || _loc9_.templateInfo.SonType == 117)
               {
                  if(_loc9_.mouldGrade >= 80)
                  {
                     _loc2_ = _loc9_.getMouldNeedCount(1) * 3;
                     _loc8_ = _loc9_.getMouldNeedCount(2) * 3;
                  }
                  else
                  {
                     _loc2_ = 10;
                     _loc8_ = 30;
                  }
               }
               else
               {
                  _loc2_ = int(_loc9_.getMouldNeedCount(1));
                  _loc8_ = int(_loc9_.getMouldNeedCount(2));
               }
               _loc6_ = int(GoodsManager.instance.getGoodsNumByTempId(_loc9_.MOULD_NEED_MATERIAL1));
               _loc3_ = int(GoodsManager.instance.getGoodsNumByTempId(_loc9_.MOULD_NEED_MATERIAL2));
               _loc4_ = uint(StoreHelper.getMouldSuccessRate(_loc9_));
               _neededGoldTxt.text = GoodsCheck.getMouldGold(_loc9_).toString();
               _blessValueTxt.text = _loc9_.blessValue + " / " + 100;
               _blessBar.setFrame(_loc9_.blessValue);
               _blessTxt.visible = true;
               _blessValueTxt.visible = true;
               _blessBar.visible = true;
               _loc4_ += _loc9_.blessValue;
               if(_loc4_ > 100)
               {
                  _loc4_ = 100;
               }
               _successRatesTxt.text = _loc4_ + "%";
               _loc7_ = int(_loc9_.MOULD_NEED_MATERIAL1);
               _loc5_ = int(_loc9_.MOULD_NEED_MATERIAL2);
            }
            else
            {
               _loc1_ = int(_loc9_.mouldGrade);
               _gradeMaxTip.visible = true;
               _castBtn.enable = false;
            }
         }
         _mate1.material(_loc7_,_loc2_,_loc6_);
         _mate2.material(_loc5_,_loc8_,_loc3_);
         _mouldItem1.setData(_loc9_,_loc1_);
         _mouldItem2.setData(_loc9_,_loc1_ + 1);
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

