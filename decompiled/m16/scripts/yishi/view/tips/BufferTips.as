package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.PlayerBufferInfo;
   import yishi.utils.DateFormatter;
   
   public class BufferTips extends BaseTip
   {
      
      private var _box:VBox;
      
      private var _title:FilterFrameText;
      
      private var _describe:FilterFrameText;
      
      private var _timeContan:Sprite;
      
      private var _remainTime:FilterFrameText;
      
      private var _time:FilterFrameText;
      
      public function BufferTips()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg.width = 230;
         _title = ComponentFactory.Instance.creatComponentByStylename("campaign.titleTxt_2");
         _describe = ComponentFactory.Instance.creatComponentByStylename("buffer.DiscribeTxt");
         _remainTime = ComponentFactory.Instance.creatComponentByStylename("campaign.rightText");
         _time = ComponentFactory.Instance.creatComponentByStylename("tips.bufferTime");
         _box = ComponentFactory.Instance.creatComponentByStylename("tips.TipContain");
         _title.autoSize = _remainTime.autoSize = _time.autoSize = "left";
         _remainTime.text = LanguageMgr.GetTranslation("public.colon",LanguageMgr.GetTranslation("yishi.view.tips.BufferTips.remainTime.text"));
         _timeContan = new Sprite();
         _timeContan.addChild(_remainTime);
         _timeContan.addChild(_time);
         _time.x = _remainTime.x + _remainTime.textWidth + 5;
         addChild(_box);
      }
      
      private function clean() : void
      {
         _box.removeAllChild();
         _time.htmlText = "";
         _time.height = 20;
      }
      
      override protected function updateTransform() : void
      {
         var _loc3_:PlayerBufferInfo = null;
         var _loc2_:String = null;
         var _loc1_:RegExp = null;
         clean();
         if(_data is PlayerBufferInfo)
         {
            _loc3_ = _data as PlayerBufferInfo;
            _loc2_ = _loc3_.description;
            _loc1_ = /\|/g;
            _loc2_ = _loc2_.replace(_loc1_,",");
            _title.htmlText = _loc3_.name;
            _describe.htmlText = _loc2_;
            _describe.height = _describe.textHeight + _describe.numLines * 4;
            _box.addChild(_title);
            _box.addChild(_describe);
            _remainTime.setFrame(1);
            if(_loc3_.bufferType == -4 && _loc3_.masterType != 1000)
            {
               _describe.height = _describe.textHeight + _describe.numLines * 2;
               _time.htmlText = LanguageMgr.GetTranslation("buffer.BasePropertyBuffer");
               _time.height = _time.textHeight + _time.numLines * 2;
               _remainTime.setFrame(2);
               _box.addChild(_timeContan);
            }
            else if(_loc3_.leftTime > 0)
            {
               showTimeStr();
               _box.addChild(_timeContan);
            }
            _box.refreshChildPos();
            _bg.height = _box.x + _box.height + 5;
            __changeHandler(null);
            (_data as PlayerBufferInfo).addEventListener("change",__changeHandler);
         }
      }
      
      private function __changeHandler(param1:Event) : void
      {
         showTimeStr();
      }
      
      private function showTimeStr() : void
      {
         if(!_data)
         {
            return;
         }
         if(!parent)
         {
            return;
         }
         if(_data is PlayerBufferInfo && _data.bufferType == -4 && PlayerBufferInfo(_data).masterType != 1000)
         {
            return;
         }
         if(_data is PlayerBufferInfo && PlayerBufferInfo(_data).bufferType == 20000)
         {
            return;
         }
         var _loc1_:String = "";
         if((_data as PlayerBufferInfo).leftTime >= 86400)
         {
            _loc1_ = int((_data as PlayerBufferInfo).leftTime / 86400) + LanguageMgr.GetTranslation("public.day") + int((_data as PlayerBufferInfo).leftTime / 3600 % 24) + LanguageMgr.GetTranslation("public.time.hour") + int((_data as PlayerBufferInfo).leftTime % 3600 / 60) + LanguageMgr.GetTranslation("public.minute");
         }
         else if((_data as PlayerBufferInfo).leftTime >= 3600)
         {
            _loc1_ = int((_data as PlayerBufferInfo).leftTime / 3600) + LanguageMgr.GetTranslation("public.time.hour") + int((_data as PlayerBufferInfo).leftTime % 3600 / 60) + LanguageMgr.GetTranslation("public.minute");
         }
         else if(_data.leftTime >= 60)
         {
            _loc1_ = int((_data as PlayerBufferInfo).leftTime / 60) + LanguageMgr.GetTranslation("public.minute");
         }
         else
         {
            _loc1_ = DateFormatter.getCountDate((_data as PlayerBufferInfo).leftTime,2,2);
         }
         _time.text = _loc1_;
      }
      
      override public function dispose() : void
      {
         (_data as PlayerBufferInfo).removeEventListener("change",__changeHandler);
         _data = null;
         ObjectUtils.disposeAllChildren(_timeContan);
         if(_title)
         {
            ObjectUtils.disposeObject(_title);
         }
         _title = null;
         if(_describe)
         {
            ObjectUtils.disposeObject(_describe);
         }
         _describe = null;
         if(_remainTime)
         {
            ObjectUtils.disposeObject(_remainTime);
         }
         _remainTime = null;
         if(_time)
         {
            ObjectUtils.disposeObject(_time);
         }
         _time = null;
         if(_box)
         {
            ObjectUtils.disposeObject(_box);
         }
         _box = null;
         if(_timeContan)
         {
            ObjectUtils.disposeObject(_timeContan);
         }
         _timeContan = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

