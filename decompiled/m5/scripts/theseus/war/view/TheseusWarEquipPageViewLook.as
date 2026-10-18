package theseus.war.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import theseus.war.item.TheseusWarEquipHItemLook;
   import yishi.datas.playerinfo.ThaneInfo;
   
   public class TheseusWarEquipPageViewLook extends Sprite
   {
      
      public var _warEquipBg:Bitmap;
      
      public var _warEquipTitle:FilterFrameText;
      
      public var _warEquipVbox:VBox;
      
      private var _itemList:Vector.<TheseusWarEquipHItemLook> = new Vector.<TheseusWarEquipHItemLook>();
      
      private var _thane:ThaneInfo;
      
      public function TheseusWarEquipPageViewLook()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         var _loc1_:TheseusWarEquipHItemLook = null;
         var _loc2_:int = 0;
         _warEquipBg = ComponentFactory.Instance.creatBitmap("asset.theseus.warEquipBg");
         _warEquipTitle = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.warEquipTitle");
         _warEquipVbox = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.warEquipVbox");
         addChild(_warEquipBg);
         addChild(_warEquipTitle);
         addChild(_warEquipVbox);
         _warEquipVbox.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new TheseusWarEquipHItemLook(_loc2_ + 1);
            _itemList[_loc2_] = _loc1_;
            _warEquipVbox.addChild(_loc1_);
            _loc2_++;
         }
         _warEquipVbox.commitChanges();
         _warEquipTitle.text = LanguageMgr.GetTranslation("theseus.war.equipTitle");
      }
      
      public function updateView() : void
      {
         var _loc2_:Array = [];
         if(_thane.warSoulInfo)
         {
            _loc2_ = _thane.warSoulInfo.getEquipBodyList();
         }
         for each(var _loc1_:TheseusWarEquipHItemLook in _itemList)
         {
            _loc1_.initData(_thane);
            _loc1_.refreshView(_loc2_);
         }
      }
      
      public function initData(param1:ThaneInfo) : void
      {
         _thane = param1;
         updateView();
      }
      
      public function dispose() : void
      {
         for each(var _loc1_:TheseusWarEquipHItemLook in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _itemList = null;
         ObjectUtils.disposeObject(_warEquipBg);
         _warEquipBg = null;
         ObjectUtils.disposeObject(_warEquipTitle);
         _warEquipTitle = null;
         ObjectUtils.disposeObject(_warEquipVbox);
         _warEquipVbox = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

