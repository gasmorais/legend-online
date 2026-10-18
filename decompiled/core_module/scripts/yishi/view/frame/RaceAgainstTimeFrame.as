package yishi.view.frame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.CommonDropTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.view.community.BaseItemView;
   
   public class RaceAgainstTimeFrame extends Frame
   {
      
      private var _back:Bitmap;
      
      private var _rewardsBg:MutipleImage;
      
      private var _clearTxt:FilterFrameText;
      
      private var _clearHBox:HBox;
      
      private var _timeTxt:FilterFrameText;
      
      private var _timeHBox:HBox;
      
      private var _btn:IconButton;
      
      private var _clear:int;
      
      private var _time:int;
      
      private var _timeStr:String;
      
      public function RaceAgainstTimeFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("RaceAgainstTimeFrame.titleText.text");
         _back = ComponentFactory.Instance.creatBitmap("asset.raceAgainstTimeFrame.back");
         _rewardsBg = ComponentFactory.Instance.creatComponentByStylename("raceAgainstTimeFrame.rewardsBg");
         _clearTxt = ComponentFactory.Instance.creatComponentByStylename("raceAgainstTimeFrame.clearTxt");
         _clearHBox = ComponentFactory.Instance.creatComponentByStylename("raceAgainstTimeFrame.clearHBox");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("raceAgainstTimeFrame.timeTxt");
         _timeHBox = ComponentFactory.Instance.creatComponentByStylename("raceAgainstTimeFrame.timeHBox");
         _btn = ComponentFactory.Instance.creatComponentByStylename("raceAgainstTimeFrame.btn");
         addToContent(_back);
         addToContent(_rewardsBg);
         addToContent(_clearTxt);
         addToContent(_clearHBox);
         addToContent(_timeTxt);
         addToContent(_timeHBox);
         addToContent(_btn);
      }
      
      public function setClearTime(param1:int, param2:String) : void
      {
         _clear = param1;
         var _loc3_:Array = param2.split(",");
         if(_loc3_.length >= 2)
         {
            _time = _loc3_[0];
            _timeStr = DateFormatter.getCountDate(_loc3_[1],2,2);
         }
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc2_:BaseItemView = null;
         var _loc4_:GoodsInfo = null;
         var _loc5_:CommonDropTempInfo = null;
         var _loc1_:Array = null;
         var _loc3_:int = 0;
         _clearTxt.htmlText = LanguageMgr.GetTranslation("RaceAgainstTimeFrame.clearTxt.text",_clear);
         _loc1_ = TempleteManager.instance.raceAgainstTimeDropTempCate.getDropsByTypeIndex(1,_clear.toString());
         if(_loc1_)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc1_.length)
            {
               _loc5_ = _loc1_[_loc3_];
               _loc4_ = new GoodsInfo();
               _loc4_.templateId = _loc5_.itemId;
               _loc4_.count = _loc5_.count;
               _loc2_ = ComponentFactory.Instance.creatCustomObject("raceAgainstTimeFrame.itemView");
               _loc2_.data = _loc4_;
               _clearHBox.addChild(_loc2_);
               _loc3_++;
            }
         }
         if(_time == -1)
         {
            _timeTxt.htmlText = LanguageMgr.GetTranslation("RaceAgainstTimeFrame.timeTxt.text1");
         }
         else if(_time > 0)
         {
            _timeTxt.htmlText = LanguageMgr.GetTranslation("RaceAgainstTimeFrame.timeTxt.text2",_timeStr);
            _loc1_ = TempleteManager.instance.raceAgainstTimeDropTempCate.getDropsByTypeIndex(2,_time.toString());
            if(_loc1_)
            {
               _loc3_ = 0;
               while(_loc3_ < _loc1_.length)
               {
                  _loc5_ = _loc1_[_loc3_];
                  _loc4_ = new GoodsInfo();
                  _loc4_.templateId = _loc5_.itemId;
                  _loc4_.count = _loc5_.count;
                  _loc2_ = ComponentFactory.Instance.creatCustomObject("raceAgainstTimeFrame.itemView");
                  _loc2_.data = _loc4_;
                  _timeHBox.addChild(_loc2_);
                  _loc3_++;
               }
            }
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _btn.addEventListener("click",__btnClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _btn.removeEventListener("click",__btnClickHandler);
      }
      
      private function __btnClickHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_rewardsBg);
         _rewardsBg = null;
         ObjectUtils.disposeObject(_clearTxt);
         _clearTxt = null;
         ObjectUtils.disposeObject(_clearHBox);
         _clearHBox = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         ObjectUtils.disposeObject(_timeHBox);
         _timeHBox = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

