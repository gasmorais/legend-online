package theseus.war.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import yishi.datas.goods.GoodsInfo;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class TheseusFuHuMetrail extends Sprite
   {
      
      public var _warBoxAdd:Bitmap;
      
      public var _fuhuMetrailIcon:BaseIconView;
      
      private var _bg:Bitmap;
      
      private var _data:GoodsInfo;
      
      public function TheseusFuHuMetrail()
      {
         super();
         initView();
      }
      
      public function get data() : GoodsInfo
      {
         return _data;
      }
      
      public function set data(param1:GoodsInfo) : void
      {
         _data = param1;
         if(_data)
         {
            _fuhuMetrailIcon.icon = IconFactory.getGoodsIconByTID(_data.templateInfo.TemplateId);
            _fuhuMetrailIcon.tipData = _data;
         }
         else
         {
            _fuhuMetrailIcon.icon = null;
            _fuhuMetrailIcon.tipData = null;
         }
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.theseus.warBoxBg");
         _warBoxAdd = ComponentFactory.Instance.creatBitmap("asset.theseus.warBoxAdd");
         _fuhuMetrailIcon = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.fuhuMetrailIcon");
         addChild(_bg);
         addChild(_warBoxAdd);
         addChild(_fuhuMetrailIcon);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_warBoxAdd);
         _warBoxAdd = null;
         ObjectUtils.disposeObject(_fuhuMetrailIcon);
         _fuhuMetrailIcon = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
      }
   }
}

