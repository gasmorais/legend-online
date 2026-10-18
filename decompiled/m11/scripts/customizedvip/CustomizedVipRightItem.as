package customizedvip
{
   import battle.utils.Helpers;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.CustomizedVipManager;
   import managers.VIPManager;
   import mvc.module.customizedvip.CustomizedVipBoxInfo;
   import mvc.module.customizedvip.CustomizedVipModel;
   import mvc.module.vip.VIPModel;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.MsgMan;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleDictionary;
   import yishi.view.base.TokenAmountItem;
   import yishi.view.tips.MessageTipManager;
   
   public class CustomizedVipRightItem extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _levelMutiImage:MutipleImage;
      
      private var _leftText:FilterFrameText;
      
      private var _numbit:BitmapData;
      
      private var _levelCon:Component;
      
      private var _rewardHbox:HBox;
      
      private var _addHbox:HBox;
      
      private var _customizedBtn:IconButton;
      
      private var _buyBtn:IconButton;
      
      private var _costItem:TokenAmountItem;
      
      private var _sellOutImage:Bitmap;
      
      private var _data:CustomizedVipBoxInfo;
      
      public function CustomizedVipRightItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.CustomizedVipRightItem.bg");
         _levelMutiImage = ComponentFactory.Instance.creatComponentByStylename("CustomizedVipRightItem.levelMutiImage");
         _leftText = ComponentFactory.Instance.creatComponentByStylename("CustomizedVipRightItem.leftText");
         _numbit = ComponentFactory.Instance.creatBitmapData("asset.CustomizedVipRightItem.numbit");
         _levelCon = ComponentFactory.Instance.creatComponentByStylename("CustomizedVipRightItem.levelCon");
         _customizedBtn = ComponentFactory.Instance.creatComponentByStylename("CustomizedVipRightItem.customizedBtn");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("CustomizedVipRightItem.buyBtn");
         _costItem = ComponentFactory.Instance.creatComponentByStylename("CustomizedVipRightItem.costItem");
         _sellOutImage = ComponentFactory.Instance.creatBitmap("asset.CustomizedVipRightItem.sellOutImage");
         _rewardHbox = ComponentFactory.Instance.creatComponentByStylename("CustomizedVipRightItem.rewardHbox");
         _addHbox = ComponentFactory.Instance.creatComponentByStylename("CustomizedVipRightItem.addHbox");
         addChild(_bg);
         addChild(_levelCon);
         addChild(_levelMutiImage);
         addChild(_leftText);
         addChild(_addHbox);
         addChild(_rewardHbox);
         addChild(_customizedBtn);
         addChild(_costItem);
         addChild(_buyBtn);
         addChild(_sellOutImage);
      }
      
      private function addEvent() : void
      {
         if(_customizedBtn)
         {
            _customizedBtn.addEventListener("click",__openCustomizedHandler);
         }
         if(_buyBtn)
         {
            _buyBtn.addEventListener("click",__buyCustomizedItemHandler);
         }
         MsgMan.addObserver("BOX_ITEM_SELECT_ALL",this,__onSelectChangeHandler);
      }
      
      private function removeEvent() : void
      {
         if(_customizedBtn)
         {
            _customizedBtn.removeEventListener("click",__openCustomizedHandler);
         }
         if(_buyBtn)
         {
            _buyBtn.removeEventListener("click",__buyCustomizedItemHandler);
         }
         MsgMan.removeObserver("BOX_ITEM_SELECT_ALL",this,__onSelectChangeHandler);
      }
      
      private function __onSelectChangeHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __openCustomizedHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("customizedvip","CUSTOMIZED_FRAME",data);
      }
      
      private function __buyCustomizedItemHandler(param1:MouseEvent) : void
      {
         if(vipModel.vipInfo.IsVipAndNoExpirt && vipModel.vipInfo.VipType != 2)
         {
            FrameControllerManager.instance.openControllerByInfo("customizedvip","BUY_FRAME",data);
            return;
         }
         MessageTipManager.instance().show(LanguageMgr.GetTranslation("CustomizedVip.buyBox.noVipAlert"));
      }
      
      public function get data() : CustomizedVipBoxInfo
      {
         return _data;
      }
      
      public function set data(param1:CustomizedVipBoxInfo) : void
      {
         _data = param1;
         if(!_data)
         {
            return;
         }
         refreshView();
      }
      
      private function refreshView() : void
      {
         NumberViewUtils.refreshValue(data.price,_levelCon,_numbit,18,22,16,18,"0123456789");
         _levelMutiImage.x = _levelCon.x + data.price.toString().length * 18;
         _leftText.text = LanguageMgr.GetTranslation("CustomizedVipRightItem.leftText.text",data.leftCount,data.maxCount);
         refreshItemView();
         if(data.leftCount <= 0)
         {
            _buyBtn.visible = false;
            _customizedBtn.visible = false;
            _costItem.visible = false;
            _sellOutImage.visible = true;
         }
         else
         {
            _sellOutImage.visible = false;
            if(model.clientBoxDic[data.type] && data.customizedItemDic.keys.length <= model.clientBoxDic[data.type].keys.length)
            {
               _customizedBtn.visible = false;
               _buyBtn.visible = true;
               _costItem.visible = true;
               _costItem.firstText = data.price + "";
            }
            else
            {
               _customizedBtn.visible = true;
               _buyBtn.visible = false;
               _costItem.visible = false;
            }
         }
      }
      
      private function refreshItemView() : void
      {
         var _loc4_:int = 0;
         var _loc1_:CustomizedVipRewardItem = null;
         var _loc5_:SimpleDictionary = null;
         var _loc2_:Bitmap = null;
         _addHbox.removeAllChild();
         _rewardHbox.removeAllChild();
         var _loc3_:Array = Helpers.getKeyList(data.customizedItemDic);
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc1_ = new CustomizedVipRewardItem(1,_loc4_);
            _loc1_.boxInfo = data;
            if(model.clientBoxDic[data.type] && model.clientBoxDic[data.type].keys.length >= data.customizedItemDic.keys.length)
            {
               _loc5_ = model.clientBoxDic[data.type];
               _loc1_.data = _loc5_[_loc3_[_loc4_]];
            }
            else
            {
               _loc1_.data = null;
            }
            _rewardHbox.addChild(_loc1_);
            if(_loc4_ != 0)
            {
               _loc2_ = ComponentFactory.Instance.creatBitmap("asset.CustomizedVipRightItem.addImage");
               _addHbox.addChild(_loc2_);
            }
            _loc4_++;
         }
      }
      
      private function get model() : CustomizedVipModel
      {
         return CustomizedVipManager.instance.model;
      }
      
      private function get vipModel() : VIPModel
      {
         return VIPManager.Instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_levelCon);
         _levelMutiImage = null;
         ObjectUtils.disposeObject(_levelMutiImage);
         _levelMutiImage = null;
         ObjectUtils.disposeObject(_leftText);
         _leftText = null;
         ObjectUtils.disposeObject(_numbit);
         _numbit = null;
         ObjectUtils.disposeObject(_customizedBtn);
         _customizedBtn = null;
         ObjectUtils.disposeObject(_costItem);
         _costItem = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_addHbox);
         _addHbox = null;
         ObjectUtils.disposeObject(_rewardHbox);
         _rewardHbox = null;
         ObjectUtils.disposeObject(_sellOutImage);
         _sellOutImage = null;
         super.dispose();
      }
   }
}

