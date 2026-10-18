package ancientartifact.view
{
   import ancientartifact.view.item.AncientEquipArmoryItem;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import events.AncientArtifactEvent;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.ancientartifact.AncientArmoryInfo;
   import mvc.module.ancientartifact.AncientArtifactModel;
   import utils.LogicUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ArmoryTemplateInfo;
   import yishi.manager.AncientArtifactManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class AcnientArmoryDeleteView extends Component
   {
      
      private var _backBg01:Bitmap;
      
      private var _backBg02:Bitmap;
      
      private var _backBg03:Bitmap;
      
      private var _deleteBtn:IconButton;
      
      private var _equipViewList:SimpleTileList;
      
      private var _baseItem:BaseItemView;
      
      private var _itemList:Array = [];
      
      private var _goods:GoodsInfo;
      
      public function AcnientArmoryDeleteView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:AncientEquipArmoryItem = null;
         var _loc2_:int = 0;
         _backBg01 = ComponentFactory.Instance.creatBitmap("asset.ancientartifact.armoryDeleteBack01");
         _backBg02 = ComponentFactory.Instance.creatBitmap("asset.ancientartifact.armoryDeleteBack02");
         _backBg03 = ComponentFactory.Instance.creatBitmap("asset.ancientartifact.upGradeViewBack11");
         _deleteBtn = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.armoryDeleteBtn");
         _equipViewList = ComponentFactory.Instance.creatCustomObject("ancientArmoryView.equipViewList",[6]);
         _baseItem = ComponentFactory.Instance.creatCustomObject("ancientartifact.deleteItemView");
         addChild(_backBg01);
         addChild(_backBg02);
         addChild(_backBg03);
         addChild(_deleteBtn);
         addChild(_equipViewList);
         addChild(_baseItem);
         _equipViewList.x = 32;
         _equipViewList.y = 75;
         _loc2_ = 0;
         while(_loc2_ < 12)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("ancientartifact.AncientEquipArmoryItem",[_loc2_]);
            _equipViewList.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_ += 1;
         }
         _backBg03.rotation = 90;
         _backBg03.x = 254;
         _backBg03.y = 185;
         _goods = new GoodsInfo();
         _goods.templateId = 6260001;
         _baseItem.data = _goods;
         _deleteBtn.enable = false;
      }
      
      private function initEvent() : void
      {
         _deleteBtn.addEventListener("click",__onClick);
         model.addEventListener("ARMORY_CHOOSE_DATA",__getGradesInfos);
      }
      
      private function __getGradesInfos(param1:AncientArtifactEvent) : void
      {
         var _loc4_:AncientEquipArmoryItem = null;
         var _loc8_:AncientArmoryInfo = null;
         var _loc3_:ArmoryTemplateInfo = null;
         var _loc7_:int = 0;
         clearData();
         var _loc2_:Array = model.chooseList;
         var _loc5_:int = int(_loc2_.length);
         var _loc6_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc4_ = _itemList[_loc7_];
            _loc8_ = model.getArmoryInfoById(_loc2_[_loc7_]);
            _loc4_.data = _loc8_;
            _loc3_ = TempleteManager.instance.armoryTempCate.getTempInfoByTemplateId(_loc8_.templateId,_loc8_.profile);
            _loc6_ += _loc3_.ResolvedCount + _loc8_.grades * _loc3_.ResolvedRate;
            if(!_loc3_)
            {
               return;
            }
            _loc7_ += 1;
         }
         if(_loc5_ > 0)
         {
            _deleteBtn.enable = true;
         }
         _goods.count = _loc6_;
         _baseItem.data = _goods;
      }
      
      private function __onClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(model.chooseList.length > 0)
         {
            AncientArtifactManager.instance.OperateArtifactReq(AncientArtifactManager.ARMORY_RESOLVE,0,0,false,0,0,model.chooseList);
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.armoryDeleteTips01");
            MessageTipManager.instance().show(_loc2_);
         }
      }
      
      private function removeEvent() : void
      {
         if(_deleteBtn)
         {
            _deleteBtn.removeEventListener("click",__onClick);
         }
         model.removeEventListener("ARMORY_CHOOSE_DATA",__getGradesInfos);
      }
      
      private function clearData() : void
      {
         var _loc1_:AncientEquipArmoryItem = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 12)
         {
            _loc1_ = _itemList[_loc2_];
            _loc1_.data = null;
            _loc2_ += 1;
         }
         _deleteBtn.enable = false;
      }
      
      private function get model() : AncientArtifactModel
      {
         return AncientArtifactManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_backBg01);
         _backBg01 = null;
         ObjectUtils.disposeObject(_backBg02);
         _backBg02 = null;
         ObjectUtils.disposeObject(_backBg03);
         _backBg03 = null;
         ObjectUtils.disposeObject(_deleteBtn);
         _deleteBtn = null;
         ObjectUtils.disposeObject(_equipViewList);
         _equipViewList = null;
         ObjectUtils.disposeObject(_baseItem);
         _baseItem = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         super.dispose();
      }
   }
}

