package chess.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.datas.templates.SelfChessBuffTempInfo;
   
   public class SelfChessOneBuffDes extends Sprite
   {
      
      private var tileTxt:FilterFrameText;
      
      private var desTxt:FilterFrameText;
      
      private var _isActive:Boolean;
      
      public function SelfChessOneBuffDes()
      {
         super();
         initView();
         isActive = false;
      }
      
      public function set isActive(param1:Boolean) : void
      {
         _isActive = param1;
         if(_isActive)
         {
            tileTxt.setFrame(1);
            desTxt.setFrame(1);
         }
         else
         {
            tileTxt.setFrame(2);
            desTxt.setFrame(2);
         }
      }
      
      private function initView() : void
      {
         tileTxt = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.oneBuffTitleTxt");
         desTxt = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.oneBuffDesTxt");
         addChild(tileTxt);
         addChild(desTxt);
      }
      
      public function refreshView(param1:SelfChessBuffTempInfo) : void
      {
         tileTxt.text = LanguageMgr.GetTranslation("selfchess.buff.title",param1.Amount,param1.TemplateName);
         desTxt.text = param1.Desc;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(tileTxt);
         tileTxt = null;
         ObjectUtils.disposeObject(desTxt);
         desTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

