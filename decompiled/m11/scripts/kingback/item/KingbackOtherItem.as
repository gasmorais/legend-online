package kingback.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.KingbackManager;
   import mvc.module.kingback.KingbackInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   
   public class KingbackOtherItem extends Sprite
   {
      
      public var _otherBarBg:Bitmap;
      
      public var _otherItemTitle:FilterFrameText;
      
      public var _otherGetBtn:IconButton;
      
      public var _otherHbox:HBox;
      
      public var _otherGetFlg:Image;
      
      private var _data:KingbackInfo;
      
      public function KingbackOtherItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _otherBarBg = ComponentFactory.Instance.creatBitmap("asset.kingback.otherBarBg");
         _otherItemTitle = ComponentFactory.Instance.creatComponentByStylename("ui.kingback.otherItemTitle");
         _otherGetBtn = ComponentFactory.Instance.creatComponentByStylename("ui.kingback.otherGetBtn");
         _otherHbox = ComponentFactory.Instance.creatCustomObject("ui.kingback.otherHbox");
         _otherGetFlg = ComponentFactory.Instance.creatComponentByStylename("ui.kingback.otherGetFlg");
         addChild(_otherBarBg);
         addChild(_otherItemTitle);
         addChild(_otherGetBtn);
         addChild(_otherHbox);
         addChild(_otherGetFlg);
         _otherGetFlg.visible = false;
         DisplayUtils.setFrame(_otherGetBtn.icon,1);
      }
      
      private function initData() : void
      {
         var _loc5_:Array = null;
         var _loc1_:BaseItemView = null;
         var _loc4_:GoodsInfo = null;
         var _loc3_:int = 0;
         if(_otherHbox.numChildren > 0)
         {
            return;
         }
         var _loc6_:Array = _data.tempInfo.getRewardList();
         var _loc2_:int = int(_loc6_ ? _loc6_.length : 0);
         _otherHbox.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc5_ = _loc6_[_loc3_];
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = _loc5_[0];
            _loc4_.count = _loc5_[1];
            _loc1_ = ComponentFactory.Instance.creatCustomObject("feedBackFrame.BaseItemView");
            _loc1_.data = _loc4_;
            _otherHbox.addChild(_loc1_);
            _loc3_++;
         }
         _otherHbox.commitChanges();
      }
      
      private function initEvent() : void
      {
         _otherGetBtn.addEventListener("click",clickHandler);
      }
      
      private function removeEvent() : void
      {
         _otherGetBtn.removeEventListener("click",clickHandler);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         KingbackManager.instance.sendOp(_data.templateId,1);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_otherBarBg);
         _otherBarBg = null;
         ObjectUtils.disposeObject(_otherItemTitle);
         _otherItemTitle = null;
         ObjectUtils.disposeObject(_otherGetBtn);
         _otherGetBtn = null;
         ObjectUtils.disposeObject(_otherHbox);
         _otherHbox = null;
         ObjectUtils.disposeObject(_otherGetFlg);
         _otherGetFlg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
      }
      
      public function set data(param1:KingbackInfo) : void
      {
         _data = param1;
         initData();
         if(_data.tempInfo.Type == 2)
         {
            _otherItemTitle.htmlText = LanguageMgr.GetTranslation("kingback.target.des" + _data.tempInfo.Type,_data.tempInfo.Topic);
         }
         else
         {
            _otherItemTitle.htmlText = LanguageMgr.GetTranslation("kingback.target.des45678",_data.tempInfo.getItemNames(),_data.tempInfo.Topic);
         }
         refreshState();
      }
      
      public function get data() : KingbackInfo
      {
         return _data;
      }
      
      public function refreshState() : void
      {
         _otherGetFlg.visible = false;
         _otherGetBtn.visible = true;
         if(_data.rewardState == 0)
         {
            DisplayUtils.setFrame(_otherGetBtn.icon,1);
            _otherGetBtn.enable = false;
         }
         else if(_data.rewardState == 1)
         {
            DisplayUtils.setFrame(_otherGetBtn.icon,2);
            _otherGetBtn.enable = true;
         }
         else if(_data.rewardState == 2)
         {
            _otherGetFlg.visible = true;
            _otherGetBtn.visible = false;
         }
      }
   }
}

