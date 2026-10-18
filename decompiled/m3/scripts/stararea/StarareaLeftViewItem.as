package stararea
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   
   public class StarareaLeftViewItem extends Component
   {
      
      private var _imgMapNode:ScaleFrameImage;
      
      private var _txtLtitle:FilterFrameText;
      
      private var _txtLcontent:FilterFrameText;
      
      private var index:int;
      
      public function StarareaLeftViewItem(param1:int)
      {
         super();
         this.index = param1;
         initView();
      }
      
      private function initView() : void
      {
         _imgMapNode = ComponentFactory.Instance.creatComponentByStylename("ui.stararea.imgMapNode");
         _txtLtitle = ComponentFactory.Instance.creatComponentByStylename("ui.stararea.txtLtitle");
         _txtLcontent = ComponentFactory.Instance.creatComponentByStylename("ui.stararea.txtLcontent");
         addChild(_imgMapNode);
         addChild(_txtLtitle);
         addChild(_txtLcontent);
         _txtLtitle.text = LanguageMgr.GetTranslation("stararea.left.title" + index);
         _txtLcontent.text = LanguageMgr.GetTranslation("stararea.left.str" + index);
         _imgMapNode.setFrame(index);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_imgMapNode);
         _imgMapNode = null;
         ObjectUtils.disposeObject(_txtLtitle);
         _txtLtitle = null;
         ObjectUtils.disposeObject(_txtLcontent);
         _txtLcontent = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

