package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import yishi.utils.StringHelper;
   
   public class OneLineTip extends BaseTip
   {
      
      protected var _enableHtml:Boolean = false;
      
      protected var _contentTxt:FilterFrameText;
      
      public function OneLineTip()
      {
         super();
      }
      
      public function set enableHtml(param1:Boolean) : void
      {
         _enableHtml = param1;
      }
      
      override protected function init() : void
      {
         super.init();
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("core.commonTipText");
         addChild(_contentTxt);
      }
      
      override protected function updateTransform() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         if(String(_data).indexOf("</") >= 0 || _enableHtml)
         {
            _contentTxt.htmlText = StringHelper.trim(String(_data));
         }
         else
         {
            if(String(_data).indexOf("\n") == -1 && String(_data).length > 90)
            {
               _loc1_ = "";
               _loc2_ = String(_data);
               _loc1_ = _loc2_;
               if(_loc1_.length > 180)
               {
                  _loc1_ = _loc2_.substr(0,89) + "\n" + _loc2_.substr(90,179) + "\n" + _loc2_.substr(179,_loc2_.length - 1);
               }
               else if(_loc1_.length > 90)
               {
                  _loc1_ = _loc2_.substr(0,89) + "\n" + _loc2_.substr(90,_loc2_.length - 1);
               }
               _data = _loc1_;
            }
            _contentTxt.text = StringHelper.trim(String(_data));
         }
         _contentTxt.width = _contentTxt.textWidth + 5;
         _bg.width = _contentTxt.width + 16;
         _bg.height = _contentTxt.height + 8;
         _contentTxt.x = _bg.x + 8;
         _contentTxt.y = _bg.y + 4;
      }
      
      override public function dispose() : void
      {
         if(_contentTxt)
         {
            if(_contentTxt.parent)
            {
               _contentTxt.parent.removeChild(_contentTxt);
            }
            _contentTxt.dispose();
         }
         _contentTxt = null;
         super.dispose();
      }
   }
}

