package blackjack
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.blackjack.BlackjackTempInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   
   public class BlackjackChip extends Component
   {
      
      private var _light:Bitmap;
      
      private var _card:Bitmap;
      
      private var _pointImage:ScaleFrameImage;
      
      private var _pointTxt:FilterFrameText;
      
      private var _container:Sprite;
      
      private var _blackjackTemp:BlackjackTempInfo;
      
      private var _frame:int;
      
      private var _exchangeTxt:FilterFrameText;
      
      public function BlackjackChip(param1:int)
      {
         super();
         _frame = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _light = ComponentFactory.Instance.creatBitmap("asset.blackjack.betPointCardLight");
         _card = ComponentFactory.Instance.creatBitmap("asset.blackjack.betPointCard");
         _pointImage = ComponentFactory.Instance.creatComponentByStylename("blackjack.betPointImage");
         _pointTxt = ComponentFactory.Instance.creatComponentByStylename("blackjack.betPointTxt");
         _container = new Sprite();
         _container.x = 52;
         _container.y = 112;
         _exchangeTxt = ComponentFactory.Instance.creatComponentByStylename("blackjack.betBlackChipTxt");
         addChild(_light);
         addChild(_card);
         addChild(_pointImage);
         addChild(_pointTxt);
         addChild(_container);
         addChild(_exchangeTxt);
         _pointImage.setFrame(_frame);
         _light.visible = false;
      }
      
      private function addEvent() : void
      {
         addEventListener("rollOver",__onOverHandler);
         addEventListener("rollOut",__onOutHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("rollOver",__onOverHandler);
         removeEventListener("rollOut",__onOutHandler);
      }
      
      public function set data(param1:BlackjackTempInfo) : void
      {
         var _loc5_:Bitmap = null;
         var _loc6_:BaseItemView = null;
         var _loc3_:GoodsInfo = null;
         var _loc2_:int = 0;
         _blackjackTemp = param1;
         var _loc4_:Array = _blackjackTemp.generalItemReward.split("|");
         var _loc7_:Array = _blackjackTemp.winItemReward.split("|");
         _loc2_ = 0;
         while(_loc2_ < _loc7_.length)
         {
            _loc5_ = ComponentFactory.Instance.creatBitmap("asset.blackjack.betPointRewardBg");
            _loc6_ = ComponentFactory.Instance.creatCustomObject("blackjack.iconRewardView");
            _loc3_ = new GoodsInfo();
            _loc3_.templateId = _loc7_[_loc2_].split(",")[0];
            _loc3_.count = _loc7_[_loc2_].split(",")[1];
            _loc6_.data = _loc3_;
            _loc5_.x = int(_loc2_ % 2) * 62;
            _loc5_.y = int(_loc2_ / 2) * 62;
            _loc6_.x = 6 + int(_loc2_ % 2) * 62;
            _loc6_.y = 5 + int(_loc2_ / 2) * 62;
            _container.addChild(_loc5_);
            _container.addChild(_loc6_);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc4_.length)
         {
            _loc5_ = ComponentFactory.Instance.creatBitmap("asset.blackjack.betPointRewardBg");
            _loc6_ = ComponentFactory.Instance.creatCustomObject("blackjack.iconRewardView");
            _loc3_ = new GoodsInfo();
            _loc3_.templateId = _loc4_[_loc2_].split(",")[0];
            _loc3_.count = _loc4_[_loc2_].split(",")[1];
            _loc6_.data = _loc3_;
            _loc5_.x = int(_loc2_ % 2) * 62;
            _loc5_.y = 173 + int(_loc2_ / 2) * 62;
            _loc6_.x = 6 + int(_loc2_ % 2) * 62;
            _loc6_.y = 178 + int(_loc2_ / 2) * 62;
            _container.addChild(_loc5_);
            _container.addChild(_loc6_);
            _loc2_++;
         }
         _loc5_ = null;
         _loc6_ = null;
         _pointTxt.text = String(param1.cost);
         _exchangeTxt.text = LanguageMgr.GetTranslation("view.blackjack.BlackjackFrame.exchangeTxt",param1.generalScoreReward);
      }
      
      public function get data() : BlackjackTempInfo
      {
         return _blackjackTemp;
      }
      
      private function __onOverHandler(param1:MouseEvent) : void
      {
         _light.visible = true;
      }
      
      private function __onOutHandler(param1:MouseEvent) : void
      {
         _light.visible = false;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_light);
         _light = null;
         ObjectUtils.disposeObject(_card);
         _card = null;
         ObjectUtils.disposeObject(_pointImage);
         _pointImage = null;
         ObjectUtils.disposeObject(_pointTxt);
         _pointTxt = null;
         ObjectUtils.disposeAllChildren(_container);
         ObjectUtils.disposeObject(_container);
         _container = null;
         ObjectUtils.disposeObject(_exchangeTxt);
         _exchangeTxt = null;
         _blackjackTemp = null;
         super.dispose();
      }
   }
}

