package avenger.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.avenger.AvengerDevilArmorHoleInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.FrameControllerManager;
   
   public class AvengerDevilArmorEquipItem extends Component
   {
      
      private var _itemBg:Bitmap;
      
      private var _gradeImage:Image;
      
      private var _lockImage:Bitmap;
      
      private var _equipCell:AvengerDevilArmorItemCell;
      
      private var _gradeText:FilterFrameText;
      
      private var _addBtn:BaseButton;
      
      private var _data:AvengerDevilArmorHoleInfo;
      
      public var pos:int;
      
      private var _flag:Boolean;
      
      public function AvengerDevilArmorEquipItem(param1:int, param2:Boolean = true)
      {
         super();
         pos = param1;
         _flag = param2;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _itemBg = ComponentFactory.Instance.creatBitmap("asset.AvengerDevilArmorEquipItem.itembg");
         _lockImage = ComponentFactory.Instance.creatBitmap("asset.AvengerDevilArmorEquipItem.lockImage");
         _equipCell = ComponentFactory.Instance.creatCustomObject("AvengerDevilArmorEquipItem.equipCell",[2,_flag]);
         _gradeImage = ComponentFactory.Instance.creatComponentByStylename("AvengerDevilArmorEquipItem.gradeImage");
         _gradeText = ComponentFactory.Instance.creatComponentByStylename("AvengerDevilArmorEquipItem.gradeText");
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("AvengerDevilArmorEquipItem.addBtn");
         addChild(_itemBg);
         addChild(_lockImage);
         addChild(_equipCell);
         addChild(_gradeImage);
         addChild(_gradeText);
         addChild(_addBtn);
         _addBtn.visible = _flag;
         _equipCell.pos = pos;
         _gradeImage.mouseChildren = _gradeImage.mouseEnabled = false;
      }
      
      private function addEvent() : void
      {
         _addBtn.addEventListener("click",__addClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_addBtn)
         {
            _addBtn.removeEventListener("click",__addClickHandler);
         }
      }
      
      private function __addClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("avenger","DEVILARMOR_CARVE_FRAME",data);
      }
      
      public function get data() : AvengerDevilArmorHoleInfo
      {
         return _data;
      }
      
      public function set data(param1:AvengerDevilArmorHoleInfo) : void
      {
         var _loc2_:GoodsInfo = null;
         _data = param1;
         if(!data)
         {
            return;
         }
         _gradeText.text = LanguageMgr.GetTranslation("public.level2",data.grade);
         if(data.isOpen)
         {
            _lockImage.visible = false;
            _equipCell.visible = true;
            _addBtn.visible = data.isOpen && _flag;
            _loc2_ = new GoodsInfo();
            _loc2_.templateId = data.inlayItem;
            _equipCell.data = _loc2_.templateInfo ? _loc2_ : null;
         }
         else
         {
            _lockImage.visible = true;
            _equipCell.data = null;
            _equipCell.visible = false;
            _addBtn.visible = false;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_itemBg);
         _itemBg = null;
         ObjectUtils.disposeObject(_lockImage);
         _lockImage = null;
         ObjectUtils.disposeObject(_gradeImage);
         _gradeImage = null;
         ObjectUtils.disposeObject(_equipCell);
         _equipCell = null;
         ObjectUtils.disposeObject(_gradeText);
         _gradeText = null;
         ObjectUtils.disposeObject(_addBtn);
         _addBtn = null;
         super.dispose();
      }
   }
}

