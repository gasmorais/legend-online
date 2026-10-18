package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import manager.LanguageMgr;
   import mvc.module.kingcontract.KingContractInfo;
   
   public class KingTipItem extends Sprite implements Disposeable
   {
      
      private var _describe:FilterFrameText;
      
      private var _timeTxt:FilterFrameText;
      
      private var _kingInfo:KingContractInfo;
      
      public function KingTipItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _describe = ComponentFactory.Instance.creatComponentByStylename("kingcontract.tips.DiscribeTxt");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("kingcontract.tips.Time");
         _describe.setFrame(1);
         _timeTxt.setFrame(1);
         addChild(_describe);
         addChild(_timeTxt);
      }
      
      public function set data(param1:KingContractInfo) : void
      {
         if(_kingInfo)
         {
            _kingInfo.removeEventListener("change",__changeHandler);
            _kingInfo.removeEventListener("complete",__completeHandler);
         }
         if(!param1)
         {
            return;
         }
         _kingInfo = param1;
         _describe.text = _kingInfo.template.Name;
         _describe.height = _describe.textHeight + _describe.numLines * 4;
         _describe.width = 135;
         var _loc2_:Number = Number(_kingInfo.leftTime);
         if(_loc2_ > 0)
         {
            __changeHandler(null);
         }
         else
         {
            _describe.setFrame(2);
            _timeTxt.setFrame(2);
            setTimeTxt(LanguageMgr.GetTranslation("kingcontract.view.CloseTxt"));
         }
         _kingInfo.addEventListener("change",__changeHandler);
         _kingInfo.addEventListener("complete",__completeHandler);
      }
      
      private function __changeHandler(param1:Event) : void
      {
         var _loc2_:String = "";
         if(_kingInfo.leftTime >= 86400)
         {
            _loc2_ = int(_kingInfo.leftTime / 86400) + LanguageMgr.GetTranslation("public.day");
         }
         else if(_kingInfo.leftTime >= 3600)
         {
            _loc2_ = int(_kingInfo.leftTime / 3600) + LanguageMgr.GetTranslation("public.time.hour");
         }
         else if(_kingInfo.leftTime >= 60)
         {
            _loc2_ = int(_kingInfo.leftTime / 60) + LanguageMgr.GetTranslation("public.minute");
         }
         else
         {
            _loc2_ = _kingInfo.leftTime + LanguageMgr.GetTranslation("task.view.TaskMobilePhoneView.Text1");
         }
         setTimeTxt(_loc2_);
      }
      
      private function __completeHandler(param1:Event) : void
      {
         _describe.setFrame(2);
         _timeTxt.setFrame(2);
         setTimeTxt(LanguageMgr.GetTranslation("kingcontract.view.CloseTxt"));
      }
      
      private function setTimeTxt(param1:String) : void
      {
         _timeTxt.text = param1;
         _timeTxt.x = 180 - _timeTxt.textWidth;
         _timeTxt.width = _timeTxt.textWidth + 3;
      }
      
      public function dispose() : void
      {
         if(_kingInfo)
         {
            _kingInfo.removeEventListener("change",__changeHandler);
            _kingInfo.removeEventListener("complete",__completeHandler);
            _kingInfo = null;
         }
         if(_timeTxt)
         {
            ObjectUtils.disposeObject(_timeTxt);
         }
         _timeTxt = null;
         if(_describe)
         {
            ObjectUtils.disposeObject(_describe);
         }
         _describe = null;
      }
   }
}

