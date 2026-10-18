package oldbacker.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.oldbacker.OldBackerItemMsg;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.OldBackerManager;
   import mvc.module.oldbacker.OldBackerModel;
   import mvc.module.oldbacker.OldBackerViewInfo;
   import utils.LogicUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class OldBackerRewardItem extends Component
   {
      
      private var _titleTxt:FilterFrameText;
      
      private var _lineImage:Bitmap;
      
      private var _hbox:HBox;
      
      private var _itemList:Array;
      
      private var _rewardBtn:IconButton;
      
      private var _noRewardBtn:IconButton;
      
      private var _data:OldBackerViewInfo;
      
      public function OldBackerRewardItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:BaseItemView = null;
         var _loc2_:int = 0;
         _itemList = [];
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("oldbacker.viewMsgText05");
         _lineImage = ComponentFactory.Instance.creatBitmap("asset.oldbacker.oldbackerViewLine03");
         _rewardBtn = ComponentFactory.Instance.creatComponentByStylename("oldbacker.viewBtn05");
         _noRewardBtn = ComponentFactory.Instance.creatComponentByStylename("oldbacker.viewBtn06");
         _hbox = ComponentFactory.Instance.creatCustomObject("oldbackerRewardItem.HBox");
         addChild(_titleTxt);
         addChild(_lineImage);
         addChild(_rewardBtn);
         addChild(_noRewardBtn);
         addChild(_hbox);
         _noRewardBtn.enable = false;
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("oldbackerview.rewardViewBaseItem");
            _hbox.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_ += 1;
         }
      }
      
      private function refreshInfo() : void
      {
         var _loc2_:BaseItemView = null;
         var _loc1_:* = null;
         var _loc4_:int = 0;
         _titleTxt.text = _data.description;
         var _loc3_:Array = getRewardList(_data.rewardItems);
         _loc4_ = 0;
         while(_loc4_ < 10)
         {
            _loc2_ = _itemList[_loc4_];
            _loc2_.data = null;
            if(_loc4_ < _loc3_.length)
            {
               _loc2_.data = _loc3_[_loc4_];
            }
            _loc4_ += 1;
         }
         if(_data.rewardState == 0)
         {
            _rewardBtn.enable = false;
            _rewardBtn.visible = true;
            _noRewardBtn.visible = false;
         }
         else if(_data.rewardState == 1)
         {
            _rewardBtn.enable = true;
            _rewardBtn.visible = true;
            _noRewardBtn.visible = false;
         }
         else if(_data.rewardState == 2)
         {
            _rewardBtn.enable = false;
            _rewardBtn.visible = false;
            _noRewardBtn.visible = true;
         }
      }
      
      private function getRewardList(param1:Array) : Array
      {
         var _loc6_:GoodsInfo = null;
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:OldBackerItemMsg = null;
         var _loc7_:int = 0;
         var _loc4_:int = int(param1.length);
         var _loc2_:Array = [];
         _loc7_ = 0;
         for(; _loc7_ < _loc4_; _loc7_ += 1)
         {
            _loc3_ = param1[_loc7_] as OldBackerItemMsg;
            _loc8_ = int(_loc3_.itemTempId);
            if(model.currentType == 0)
            {
               if(_loc8_ != -400 && _loc8_ != -500)
               {
                  continue;
               }
               _loc5_ = Math.ceil(_loc3_.count * model.chargeTotalCount / 100);
            }
            else
            {
               _loc5_ = int(_loc3_.count);
            }
            _loc6_ = new GoodsInfo();
            _loc6_.templateId = _loc8_;
            _loc6_.count = _loc5_;
            _loc2_.push(_loc6_);
         }
         return _loc2_;
      }
      
      private function addEvent() : void
      {
         _rewardBtn.addEventListener("click",__onRewardClick);
      }
      
      private function __onRewardClick(param1:MouseEvent) : void
      {
         if(_data.rewardTypes == 0 && model.chargeTotalCount == 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("OldBackerRewardItem.charge.alertContent"));
            return;
         }
         OldBackerManager.instance.sendInfo(3,_data.templateId);
      }
      
      private function removeEvent() : void
      {
         if(_rewardBtn)
         {
            _rewardBtn.removeEventListener("click",__onRewardClick);
         }
      }
      
      private function get model() : OldBackerModel
      {
         return OldBackerManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_titleTxt);
         _titleTxt = null;
         ObjectUtils.disposeObject(_lineImage);
         _lineImage = null;
         ObjectUtils.disposeObject(_rewardBtn);
         _rewardBtn = null;
         ObjectUtils.disposeObject(_noRewardBtn);
         _noRewardBtn = null;
         ObjectUtils.disposeAllChildren(_hbox);
         ObjectUtils.disposeObject(_hbox);
         _hbox = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = [];
         super.dispose();
      }
      
      public function set data(param1:OldBackerViewInfo) : void
      {
         _data = param1;
         refreshInfo();
      }
   }
}

