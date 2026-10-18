package theseuspvp.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class TheseusPvpDropItem extends Sprite
   {
      
      private var _data:GoodsInfo;
      
      private var _icon:BaseIconView;
      
      private var _numTxt:FilterFrameText;
      
      public function TheseusPvpDropItem()
      {
         super();
         initView();
      }
      
      public function set data(param1:GoodsInfo) : void
      {
         _data = param1;
         if(param1)
         {
            _icon.icon = IconFactory.getGoodsIconByTID(param1.templateId);
            _numTxt.text = LanguageMgr.GetTranslation("theseuspvp.dropx",param1.count);
         }
      }
      
      private function initView() : void
      {
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.dropNumTxt");
         _icon = ComponentFactory.Instance.creatCustomObject("ui.theseuspvp.dropIcon");
         addChild(_icon);
         addChild(_numTxt);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
      }
   }
}

