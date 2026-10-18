package ylex.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import yishi.view.community.TimeDownView;
   
   public class YLExpedtionMainView extends Sprite
   {
      
      public var _mianBg:MutipleImage;
      
      public var _cleftNum:FilterFrameText;
      
      public var _longBtn:BaseButton;
      
      public var _backBtn:IconButton;
      
      public var ydList:Vector.<YLExpeditionItem>;
      
      public var _bigNode:YLExpedtionBigNodeItem;
      
      private var _headView:YLExpedtionHeadInfoView;
      
      public var _time:TimeDownView;
      
      public function YLExpedtionMainView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _mianBg = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedition.mianBg");
         _cleftNum = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedition.cleftNum");
         _longBtn = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedition.longBtn");
         _backBtn = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedition.backBtn");
         _bigNode = ComponentFactory.Instance.creatCustomObject("ylex.view.YLExpedtionBigNodeItem");
         _headView = ComponentFactory.Instance.creatCustomObject("ylex.view.YLExpedtionHeadInfoView");
         _time = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedtion.ydid.sneakTime");
         addChild(_mianBg);
         addChild(_cleftNum);
         addChild(_longBtn);
         addChild(_backBtn);
         addChild(_bigNode);
         addChild(_headView);
         addChild(_time);
         initYd();
      }
      
      private function initYd() : void
      {
         var _loc1_:YLExpeditionItem = null;
         var _loc2_:int = 0;
         ydList = new Vector.<YLExpeditionItem>();
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("ui.ylexpedition.yd" + (_loc2_ + 1));
            addChild(_loc1_);
            ydList[_loc2_] = _loc1_;
            _loc2_++;
         }
         _cleftNum.text = "0";
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_mianBg);
         _mianBg = null;
         ObjectUtils.disposeObject(_cleftNum);
         _cleftNum = null;
         ObjectUtils.disposeObject(_longBtn);
         _longBtn = null;
         ObjectUtils.disposeObject(_backBtn);
         _backBtn = null;
         ObjectUtils.disposeObject(_bigNode);
         _bigNode = null;
         ObjectUtils.disposeObject(_headView);
         _headView = null;
         for each(var _loc1_:YLExpeditionItem in ydList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         ydList = null;
         if(_time)
         {
            ObjectUtils.disposeObject(_time);
         }
         _time = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

