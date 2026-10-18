package thessbox.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class ThessBoxAddNUI extends Sprite implements ISelectable
   {
      
      protected var _bg:ScaleBitmapImage;
      
      protected var _addnIcon:BaseIconView;
      
      protected var _flg:Bitmap;
      
      private var _data:int;
      
      private var _selected:Boolean = false;
      
      public function ThessBoxAddNUI()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("thessbox.chNBack");
         _addnIcon = ComponentFactory.Instance.creatCustomObject("ui.thessbox.addnIcon");
         _flg = ComponentFactory.Instance.creatBitmap("asset.thessbox.chooseLight");
         addChild(_bg);
         addChild(_addnIcon);
         addChild(_flg);
         _flg.visible = false;
         _flg.height = 126;
      }
      
      public function set data(param1:int) : void
      {
         var _loc2_:SkillTempInfo = null;
         _data = param1;
         if(_data > 0)
         {
            visible = true;
            _loc2_ = TempleteManager.instance.getSkillById(_data);
            _addnIcon.icon = IconFactory.getTecIconByIcon(_loc2_.Icons);
            _addnIcon.tipData = _loc2_;
         }
         else
         {
            visible = false;
         }
      }
      
      public function get data() : int
      {
         return _data;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         _flg.visible = _selected;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_addnIcon);
         _addnIcon = null;
         ObjectUtils.disposeObject(_flg);
         _flg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

