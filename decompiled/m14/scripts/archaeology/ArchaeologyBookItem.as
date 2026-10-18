package archaeology
{
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.archeology.ArchaeologyModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ArchaeologyBookTemplate;
   import yishi.datas.templates.ArchaeologyItemTemplate;
   import yishi.datas.templates.FurnitureTempInfo;
   import yishi.manager.ArchaeologyManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class ArchaeologyBookItem extends Component
   {
      
      private var itemBack:Bitmap;
      
      private var getBtn:BaseButton;
      
      private var bookName:FilterFrameText;
      
      private var condictionText:FilterFrameText;
      
      private var rewardText:FilterFrameText;
      
      private var hasGetImage:Bitmap;
      
      private var rewardHbox:HBox;
      
      private var textBox:Component;
      
      private var _data:ArchaeologyBookTemplate;
      
      public function ArchaeologyBookItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         itemBack = ComponentFactory.Instance.creatBitmap("asset.ArchaeologyBookItem.itemBack");
         getBtn = ComponentFactory.Instance.creatComponentByStylename("ArchaeologyBookItem.getBtn");
         hasGetImage = ComponentFactory.Instance.creatBitmap("asset.ArchaeologyBookItem.hasGetImage");
         bookName = ComponentFactory.Instance.creatComponentByStylename("ArchaeologyBookItem.bookName");
         condictionText = ComponentFactory.Instance.creatComponentByStylename("ArchaeologyBookItem.condictionText");
         rewardText = ComponentFactory.Instance.creatComponentByStylename("ArchaeologyBookItem.rewardText");
         rewardHbox = ComponentFactory.Instance.creatComponentByStylename("ArchaeologyBookItem.rewardHbox");
         textBox = ComponentFactory.Instance.creatComponentByStylename("ArchaeologyBookItem.textbox");
         addChild(itemBack);
         addChild(bookName);
         addChild(condictionText);
         addChild(rewardText);
         addChild(rewardHbox);
         addChild(textBox);
         addChild(getBtn);
         getBtn.visible = false;
         addChild(hasGetImage);
         hasGetImage.visible = false;
      }
      
      private function addEvent() : void
      {
         getBtn.addEventListener("click",__getRewardHandler);
      }
      
      private function removeEvent() : void
      {
         if(getBtn)
         {
            getBtn.removeEventListener("click",__getRewardHandler);
         }
      }
      
      private function __getRewardHandler(param1:MouseEvent) : void
      {
         ArchaeologyManager.instance.sendArchaeologyRequest(4,_data.Id);
      }
      
      public function set data(param1:ArchaeologyBookTemplate) : void
      {
         var _loc6_:int = 0;
         var _loc7_:BaseItemView = null;
         var _loc10_:GoodsInfo = null;
         var _loc2_:* = undefined;
         var _loc3_:FurnitureTempInfo = null;
         var _loc4_:Component = null;
         var _loc11_:FilterFrameText = null;
         var _loc5_:ArchaeologyItemTemplate = null;
         var _loc8_:String = null;
         var _loc14_:String = null;
         _data = param1;
         cleanData();
         if(!_data)
         {
            return;
         }
         bookName.text = _data.Name;
         condictionText.text = LanguageMgr.GetTranslation("ArchaeologyBookItem.condictionText.text");
         rewardText.text = LanguageMgr.GetTranslation("ArchaeologyBookItem.rewardText.text");
         var _loc9_:int = getRewardLength();
         var _loc12_:int = getBookTextLength();
         _loc6_ = 1;
         while(_loc6_ <= _loc9_)
         {
            _loc7_ = ComponentFactory.Instance.creatCustomObject("ArchaeologyBookItem.baseItem");
            _loc10_ = new GoodsInfo();
            _loc10_.templateId = _data["RewardId" + _loc6_];
            _loc10_.count = _data["RewardCount" + _loc6_];
            _loc7_.data = _loc10_;
            rewardHbox.addChild(_loc7_);
            _loc6_++;
         }
         if(_data.RewardFurnitureId != 0)
         {
            if(DisplayLoader.Context.applicationDomain.getDefinition("map.campaign.view.house.FurnitureBagCell") as Class)
            {
               _loc2_ = ComponentFactory.Instance.creatCustomObject("ArchaeologyBookItem.FurnitureBagCell");
               _loc3_ = TempleteManager.instance.furnitureTemplateCate.getTempById(_data.RewardFurnitureId);
               if(_loc3_)
               {
                  _loc2_.furniture = _loc3_;
                  _loc2_.refreshTxt(_data.RewardFurnitureCount);
                  _loc2_.isCanClickItem = false;
               }
               rewardHbox.addChild(_loc2_);
            }
         }
         _loc6_ = 1;
         while(_loc6_ <= _loc12_)
         {
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("ArchaeologyBookItem.textContiner");
            _loc11_ = ComponentFactory.Instance.creatComponentByStylename("ArchaeologyBookItem.needBookText");
            _loc5_ = TempleteManager.instance.archaeologyItemTemplateCate.getTemplateByID(_data["Collection" + _loc6_]);
            if(_loc5_)
            {
               _loc11_.text = _loc5_.Name;
               _loc11_.setFrame(model.getGoodItemStateById(_data["Collection" + _loc6_]));
               _loc4_.addChild(_loc11_);
               _loc8_ = LanguageMgr.GetTranslation("archaeology.ArchaeologyBookItem.type" + _loc5_.Type);
               _loc14_ = LanguageMgr.GetTranslation("archaeology.mapArea.mapName" + _loc5_.MapId);
               _loc4_.tipData = LanguageMgr.GetTranslation("ArchaeologyBookItem.needBookText.tipdata",_loc14_,_loc8_);
               _loc4_.x = 0;
               _loc4_.y = (_loc6_ - 1) * 20;
               textBox.addChild(_loc4_);
            }
            _loc6_++;
         }
         var _loc13_:int = int(model.checkHandBookStateById(_data.Id));
         if(_loc13_ == 2)
         {
            getBtn.enable = false;
            getBtn.visible = true;
         }
         else if(_loc13_ == 1)
         {
            getBtn.enable = true;
            getBtn.visible = true;
         }
         else
         {
            hasGetImage.visible = true;
         }
      }
      
      private function cleanData() : void
      {
         rewardHbox.removeAllChild();
         ObjectUtils.disposeAllChildren(textBox);
         bookName.text = "";
         rewardText.text = "";
         condictionText.text = "";
         getBtn.visible = false;
         hasGetImage.visible = false;
      }
      
      private function getRewardLength() : int
      {
         var _loc1_:int = 0;
         if(_data.RewardId1 != 0)
         {
            _loc1_++;
         }
         if(_data.RewardId2 != 0)
         {
            _loc1_++;
         }
         if(_data.RewardId3 != 0)
         {
            _loc1_++;
         }
         if(_data.RewardId4 != 0)
         {
            _loc1_++;
         }
         return _loc1_;
      }
      
      private function getBookTextLength() : int
      {
         var _loc1_:int = 0;
         if(_data.Collection1 != 0)
         {
            _loc1_++;
         }
         if(_data.Collection2 != 0)
         {
            _loc1_++;
         }
         if(_data.Collection3 != 0)
         {
            _loc1_++;
         }
         return _loc1_;
      }
      
      private function get model() : ArchaeologyModel
      {
         return ArchaeologyManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(itemBack)
         {
            ObjectUtils.disposeObject(itemBack);
         }
         itemBack = null;
         if(bookName)
         {
            ObjectUtils.disposeObject(bookName);
         }
         bookName = null;
         if(condictionText)
         {
            ObjectUtils.disposeObject(condictionText);
         }
         condictionText = null;
         if(rewardText)
         {
            ObjectUtils.disposeObject(rewardText);
         }
         rewardText = null;
         if(rewardHbox)
         {
            ObjectUtils.disposeObject(rewardHbox);
         }
         rewardHbox = null;
         if(textBox)
         {
            ObjectUtils.disposeObject(textBox);
         }
         textBox = null;
         if(getBtn)
         {
            ObjectUtils.disposeObject(getBtn);
         }
         getBtn = null;
         if(hasGetImage)
         {
            ObjectUtils.disposeObject(hasGetImage);
         }
         hasGetImage = null;
         _data = null;
         super.dispose();
      }
   }
}

