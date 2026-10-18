package royaltyboss
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.royaltyboss.RoyaltyBossModel;
   import yishi.filter.UIFilter;
   import yishi.manager.RoyaltyBossManager;
   import yishi.utils.NumberViewUtils;
   
   public class RoyaltyLevelItem extends Component implements ISelectable
   {
      
      private var _bg:Bitmap;
      
      private var _selectedBg:Bitmap;
      
      private var _txt:GradientText;
      
      private var _txt1:GradientText;
      
      private var _levelSprite:Sprite;
      
      private var _numImg:BitmapData;
      
      private var _selected:Boolean;
      
      private var _index:int;
      
      public function RoyaltyLevelItem(param1:int)
      {
         super();
         _index = param1;
         initView();
         this.buttonMode = true;
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.RoyaltyLevelItem.bg");
         _selectedBg = ComponentFactory.Instance.creatBitmap("asset.RoyaltyLevelItem.selectedBg");
         _txt = ComponentFactory.Instance.creatComponentByStylename("royaltyLevelItem.txt");
         _txt1 = ComponentFactory.Instance.creatComponentByStylename("royaltyLevelItem.txt1");
         _numImg = ComponentFactory.Instance.creatBitmapData("asset.RoyaltyLevelItem.numImg");
         _levelSprite = new Sprite();
         addChild(_bg);
         addChild(_selectedBg);
         addChild(_txt);
         addChild(_txt1);
         addChild(_levelSprite);
         _selectedBg.visible = false;
         _txt.text = LanguageMgr.GetTranslation("royaltyLevelItem.txt.text");
         _txt1.text = LanguageMgr.GetTranslation("royaltyLevelItem.txt.text1");
         refreshView();
      }
      
      private function refreshView() : void
      {
         NumberViewUtils.refreshValue(_index,_levelSprite,_numImg,18,23,16,18,"0123456789");
         _levelSprite.x = _index >= 10 ? 49 : 55;
         _levelSprite.y = 31;
         if(_index > model.royaltyLevel)
         {
            this.filters = [UIFilter.getGrayFilter()];
         }
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
         _selectedBg.visible = _selected;
      }
      
      private function get model() : RoyaltyBossModel
      {
         return RoyaltyBossManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_selectedBg);
         _selectedBg = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeObject(_txt1);
         _txt1 = null;
         ObjectUtils.disposeObject(_levelSprite);
         _levelSprite = null;
         ObjectUtils.disposeObject(_numImg);
         _numImg = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

