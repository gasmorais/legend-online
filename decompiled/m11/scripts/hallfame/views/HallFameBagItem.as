package hallfame.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.pb.helper.army.ThaneInfoHelper;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import funny.datas.FunnyBagData;
   import funny.datas.FunnyData;
   import funny.datas.FunnyRewardData;
   import manager.LanguageMgr;
   import managers.FunnyManager;
   import mvc.module.fashion.FashionModel;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class HallFameBagItem extends Component
   {
      
      private var _hBox:HBox;
      
      private var _hBox2:HBox;
      
      private var _hasGet:Bitmap;
      
      private var _wearBtn:IconButton;
      
      private var _getBtn:IconButton;
      
      private var _data:FunnyBagData;
      
      private var _filters:UIFilter;
      
      private var _tmpArr:Array;
      
      public function HallFameBagItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _hBox = ComponentFactory.Instance.creatComponentByStylename("HallFameBagItem.hBox");
         _hBox2 = ComponentFactory.Instance.creatComponentByStylename("HallFameBagItem.hBox2");
         _hasGet = ComponentFactory.Instance.creatBitmap("asset.hallfame.ReceivedImg");
         _wearBtn = ComponentFactory.Instance.creatComponentByStylename("funnyRewardItem.wearBtn");
         _wearBtn.x = 305;
         _wearBtn.y = 5;
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("HallFameBagItem.getBtn");
         addChild(_hBox);
         addChild(_hBox2);
         addChild(_hasGet);
         addChild(_wearBtn);
         addChild(_getBtn);
         _filters = new UIFilter();
         _tmpArr = [];
      }
      
      public function set data(param1:FunnyBagData) : void
      {
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:BaseItemView = null;
         var _loc6_:GoodsInfo = null;
         var _loc9_:GoodsTemplateInfo = null;
         var _loc8_:MovieImage = null;
         for each(var _loc2_:MovieImage in _tmpArr)
         {
            ObjectUtils.disposeObject(_loc2_);
         }
         if(param1 == null)
         {
            return;
         }
         _data = param1;
         _hBox.disposeAllChildren();
         _hBox2.disposeAllChildren();
         var _loc3_:Array = [];
         _loc7_ = 1;
         while(_loc7_ < 5)
         {
            if(_loc7_ == 1)
            {
               if(_data.conditionList[0].bak != 0)
               {
                  _loc3_.push(_data.conditionList[0].bak);
               }
            }
            else if(_data.conditionList[0]["bak" + _loc7_] != 0)
            {
               _loc3_.push(_data.conditionList[0]["bak" + _loc7_]);
            }
            _loc7_++;
         }
         _loc5_ = 0;
         while(_loc5_ < _data.rewardList.length)
         {
            if(_data.rewardList[_loc5_].temType == 1)
            {
               _loc4_ = ComponentFactory.Instance.creatCustomObject("HallFameBagItem.BaseItemView");
               _loc6_ = new GoodsInfo();
               _loc6_.templateId = _data.rewardList[_loc5_].temId;
               _loc6_.count = _data.rewardList[_loc5_].count;
               _loc6_.showCount = true;
               _loc6_.isBinds = _data.rewardList[_loc5_].isBind;
               _loc6_.strengthenGrade = _data.rewardList[_loc5_].strengthenGrade;
               _loc4_.data = _loc6_;
               if(_loc3_.indexOf(_loc6_.templateId) == -1)
               {
                  _hBox2.addChild(_loc4_);
               }
               else
               {
                  _hBox.addChild(_loc4_);
               }
               _loc9_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.rewardList[_loc5_].temId);
               if(_loc9_ && _loc9_.Profile >= 5)
               {
                  _loc8_ = ComponentFactory.Instance.creatComponentByStylename("funny.LightEffect");
                  _loc8_.mouseEnabled = false;
                  _loc8_.mouseChildren = false;
                  _loc8_.x = _loc4_.x + 21;
                  if(_loc3_.indexOf(_loc6_.templateId) == -1)
                  {
                     _loc8_.y = _loc4_.y + 19;
                  }
                  else
                  {
                     _loc8_.y = _loc4_.y + 19 - 50;
                  }
                  addChild(_loc8_);
                  _tmpArr.push(_loc8_);
               }
            }
            _loc5_++;
         }
         if(hasFashion)
         {
            _wearBtn.visible = true;
         }
         else
         {
            _wearBtn.visible = false;
         }
         setState();
      }
      
      public function filterEquip(param1:GoodsInfo) : Boolean
      {
         var _loc2_:int = int(ThaneInfoHelper.getJob(ArmyManager.instance.thane.job));
         if(param1.templateInfo.Job == "0" || param1.templateInfo.Job.indexOf(_loc2_ + "") != -1 || param1.templateInfo.Job == "99")
         {
            return true;
         }
         return false;
      }
      
      public function get data() : FunnyBagData
      {
         return _data;
      }
      
      public function setState() : void
      {
         if(_data == null)
         {
            return;
         }
         switch(int(_data.status) - 1)
         {
            case 0:
               _filters.setNormalFilter(this);
               if(_hasGet)
               {
                  _hasGet.visible = false;
               }
               if(_getBtn)
               {
                  _getBtn.visible = true;
                  if(open)
                  {
                     _getBtn.enable = true;
                  }
                  else
                  {
                     _getBtn.enable = false;
                  }
               }
               if(_wearBtn)
               {
                  _wearBtn.enable = true;
               }
               break;
            case 1:
               _filters.setGrayFilter(this);
               if(_hasGet)
               {
                  _hasGet.visible = true;
               }
               if(_getBtn)
               {
                  _getBtn.visible = false;
               }
               if(_wearBtn)
               {
                  _wearBtn.enable = false;
                  _wearBtn.visible = false;
               }
               break;
            case 2:
               _filters.setNormalFilter(this);
               if(_hasGet)
               {
                  _hasGet.visible = false;
               }
               if(_getBtn)
               {
                  _getBtn.visible = true;
                  _getBtn.enable = false;
               }
               if(_wearBtn)
               {
                  _wearBtn.enable = true;
               }
         }
      }
      
      private function get open() : Boolean
      {
         var _loc1_:FunnyData = FunnyManager.instance.model.findDataByType(146);
         if(!_loc1_)
         {
            return false;
         }
         if(_loc1_.startTime < playerModel.nowDate && playerModel.nowDate < _loc1_.endTime)
         {
            return true;
         }
         return false;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         if(!open)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("feedback.FeedBackItem.outDate"));
            return;
         }
         if(FunnyManager.instance.model.findDataByType(146).endTime <= PlayerManager.instance.currentPlayerModel.nowDate)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("feedback.FeedBackItem.outDate"));
            return;
         }
         FunnyManager.instance.sendGetBag(2,_data.activeId,_data.id);
      }
      
      private function __wearBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc5_:ShopGoodsInfo = null;
         var _loc7_:GoodsTemplateInfo = null;
         if(!hasFashion)
         {
            return;
         }
         var _loc3_:Array = [];
         var _loc6_:Vector.<GoodsTemplateInfo> = new Vector.<GoodsTemplateInfo>();
         var _loc4_:Vector.<ShopGoodsInfo> = new Vector.<ShopGoodsInfo>();
         _loc6_.push(null);
         _loc6_.push(null);
         _loc6_.push(null);
         _loc6_.push(null);
         for each(var _loc2_:FunnyRewardData in _data.rewardList)
         {
            if(isFashion(_loc2_))
            {
               _loc5_ = TempleteManager.instance.getShopTempInfoByItemId(_loc2_.temId);
               _loc4_.push(_loc5_);
               _loc7_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc2_.temId);
               if(_loc7_.SonType == 109)
               {
                  _loc6_[0] = _loc7_;
               }
               else if(_loc7_.SonType == 111)
               {
                  _loc6_[1] = _loc7_;
               }
               else if(_loc7_.SonType == 112)
               {
                  _loc6_[2] = _loc7_;
               }
               else if(_loc7_.SonType == 110)
               {
                  _loc6_[3] = _loc7_;
               }
            }
         }
         FrameControllerManager.instance.openControllerByInfo("shop",9,[_loc6_,null,buyWingFunction]);
      }
      
      private function buyWingFunction(param1:Vector.<ShopGoodsInfo>) : void
      {
         MessageTipManager.instance().show(LanguageMgr.GetTranslation("funny.view.FunnyBagItem.cannotBuy"));
      }
      
      private function isFashion(param1:FunnyRewardData) : Boolean
      {
         var _loc2_:GoodsInfo = new GoodsInfo();
         _loc2_.templateId = param1.temId;
         _loc2_.count = param1.count;
         _loc2_.isBinds = param1.isBind;
         _loc2_.strengthenGrade = param1.strengthenGrade <= 0 ? 1 : param1.strengthenGrade;
         if(fashionModel.isFashion(_loc2_))
         {
            return true;
         }
         return false;
      }
      
      private function get hasFashion() : Boolean
      {
         var _loc2_:GoodsInfo = null;
         if(!_data || _data.rewardList.length <= 0)
         {
            return false;
         }
         for each(var _loc1_:FunnyRewardData in _data.rewardList)
         {
            _loc2_ = new GoodsInfo();
            _loc2_.templateId = _loc1_.temId;
            _loc2_.count = _loc1_.count;
            _loc2_.isBinds = _loc1_.isBind;
            _loc2_.strengthenGrade = _loc1_.strengthenGrade <= 0 ? 1 : _loc1_.strengthenGrade;
            if(fashionModel.isFashion(_loc2_))
            {
               return true;
            }
         }
         return false;
      }
      
      private function get fashionModel() : FashionModel
      {
         return FrameControllerManager.instance.fashionCodeController.model;
      }
      
      private function initEvent() : void
      {
         if(_wearBtn)
         {
            _wearBtn.addEventListener("click",__wearBtnClickHandler);
         }
         if(_getBtn)
         {
            _getBtn.addEventListener("click",__clickHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_wearBtn)
         {
            _wearBtn.removeEventListener("click",__wearBtnClickHandler);
         }
         if(_getBtn)
         {
            _getBtn.removeEventListener("click",__clickHandler);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _filters = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeObject(_hBox2);
         _hBox2 = null;
         if(_hasGet)
         {
            _hasGet.filters = null;
         }
         ObjectUtils.disposeObject(_hasGet);
         _hasGet = null;
         ObjectUtils.disposeObject(_getBtn);
         _getBtn = null;
         ObjectUtils.disposeObject(_wearBtn);
         _wearBtn = null;
         _data = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

