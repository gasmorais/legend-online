package chat.view
{
   import chat.datas.ExpressionItemData;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ExpressionItem extends Sprite implements Disposeable
   {
      
      private var _back:Bitmap;
      
      private var expressionIcon:MovieClip;
      
      private var _data:ExpressionItemData;
      
      public function ExpressionItem()
      {
         super();
         buttonMode = true;
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.chatII.ExpressionSelected");
         _back.visible = false;
         addChild(_back);
      }
      
      private function initEvents() : void
      {
         addEventListener("rollOver",__rollOverHandler);
         addEventListener("rollOut",__rollOutHandler);
         addEventListener("click",__clickHandler);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("rollOver",__rollOverHandler);
         removeEventListener("rollOut",__rollOutHandler);
         removeEventListener("click",__clickHandler);
      }
      
      private function __rollOverHandler(param1:MouseEvent) : void
      {
         if(_data.eroll != null)
         {
            _data.eroll(_data.ename);
         }
         _back.visible = true;
      }
      
      private function __rollOutHandler(param1:MouseEvent) : void
      {
         if(_data.eroll != null)
         {
            _data.eroll();
         }
         _back.visible = false;
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         if(_data.eclick != null)
         {
            _data.eclick(_data.eindex);
         }
      }
      
      public function set data(param1:ExpressionItemData) : void
      {
         _data = param1;
         if(_data)
         {
            expressionIcon = ComponentFactory.Instance.creat("chatII.Expression" + _data.eindex);
            expressionIcon.x = 3;
            expressionIcon.y = 5;
            addChild(expressionIcon);
         }
      }
      
      public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

