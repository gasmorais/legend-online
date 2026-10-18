package marry.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.MarryManager;
   import mvc.module.marry.MarryProposeInfo;
   
   public class ProposeBoxItem extends Sprite implements Disposeable
   {
      
      private var _nameTxt:FilterFrameText;
      
      private var _mouseOverImg:Bitmap;
      
      private var _data:MarryProposeInfo;
      
      public function ProposeBoxItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("core.IMMsgBoxItemNameTxt");
         _mouseOverImg = ComponentFactory.Instance.creatBitmap("asset.core.IMMsgBoxItemMouseOverBg");
         _mouseOverImg.alpha = 0;
         addChild(_mouseOverImg);
         addChild(_nameTxt);
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__clickHandler);
         addEventListener("rollOver",__rollOverHandler);
         addEventListener("rollOut",__rollOutHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__clickHandler);
         removeEventListener("rollOver",__rollOverHandler);
         removeEventListener("rollOut",__rollOutHandler);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         if(_data)
         {
            MarryManager.instance.creatProposeAnswerFrame(_data);
         }
      }
      
      private function __rollOverHandler(param1:MouseEvent) : void
      {
         if(_nameTxt)
         {
            _nameTxt.setFrame(2);
         }
         _mouseOverImg.alpha = 1;
      }
      
      private function __rollOutHandler(param1:MouseEvent) : void
      {
         if(_nameTxt)
         {
            _nameTxt.setFrame(1);
         }
         _mouseOverImg.alpha = 0;
      }
      
      public function get data() : MarryProposeInfo
      {
         return _data;
      }
      
      public function set data(param1:MarryProposeInfo) : void
      {
         var _loc2_:String = null;
         _data = param1;
         if(_data)
         {
            _nameTxt.text = LanguageMgr.GetTranslation("marry.view.ProposeBoxItem.nameTxt",_data.nickNameA);
            _loc2_ = _nameTxt.text;
            if(_loc2_.length > 23)
            {
               _nameTxt.text = _loc2_.substr(0,22) + "...";
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_nameTxt)
         {
            _nameTxt.dispose();
         }
         _nameTxt = null;
         _mouseOverImg = null;
         _data = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

