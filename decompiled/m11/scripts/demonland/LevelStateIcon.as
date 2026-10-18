package demonland
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.demonland.DemonLandModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.DemonLandDropTemplate;
   import yishi.datas.templates.DemonLandTemplate;
   import yishi.filter.UIFilter;
   import yishi.manager.DemonLandManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.NumberViewUtils;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class LevelStateIcon extends Component
   {
      
      public static const STATE_LOCK:int = 1;
      
      public static const STATE_PASSED:int = 2;
      
      public static const STATE_CURRENT:int = 3;
      
      public static const STATE_BOSS:int = 4;
      
      private var _icon:ScaleFrameImage;
      
      private var _lightFilterStr:String = "core.DefaultFilter,core.LightFilter,core.DefaultFilter,core.GrayFilter";
      
      private var _lightFilter:Array;
      
      private var spNum1:Sprite;
      
      private var spNum2:Sprite;
      
      private var numBitmap:BitmapData;
      
      private var chapterId:int;
      
      private var nodeNum:int;
      
      private var line:Bitmap;
      
      private var goodsItem:BaseItemView;
      
      private var bossItem:BaseItemView;
      
      private var template:DemonLandTemplate;
      
      private var myState:int;
      
      private var isBoss:Boolean;
      
      private var grayFilter:UIFilter;
      
      public function LevelStateIcon(param1:int)
      {
         nodeNum = param1;
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         grayFilter = new UIFilter();
         _lightFilter = ComponentFactory.Instance.creatFrameFilters(_lightFilterStr);
         _icon = ComponentFactory.Instance.creatComponentByStylename("DemonLand.LevelStateIcon.icon");
         goodsItem = ComponentFactory.Instance.creatCustomObject("demonland.goodsItem1");
         bossItem = ComponentFactory.Instance.creatCustomObject("demonland.goodsItem2");
         numBitmap = ComponentFactory.Instance.creatBitmapData("asset.DemonLand.resource.level.num");
         line = ComponentFactory.Instance.creatBitmap("asset.DemonLand.resource.level.line");
         spNum1 = new Sprite();
         spNum2 = new Sprite();
         _icon.buttonMode = true;
         _icon.setFrame(1);
         bossItem.visible = false;
         addChild(_icon);
         addChild(spNum1);
         addChild(spNum2);
         addChild(goodsItem);
         addChild(bossItem);
         addChild(line);
         line.x = 53;
         line.y = 123;
         spNum1.x = 38;
         spNum1.y = 117;
         spNum2.x = 62;
         spNum2.y = 117;
      }
      
      public function setState(param1:int) : void
      {
         myState = param1;
         goodsItem.visible = param1 == 2 ? false : true;
         if(isBoss)
         {
            return;
         }
         _icon.setFrame(param1);
      }
      
      public function set isPass(param1:Boolean) : void
      {
         if(param1)
         {
            grayFilter.setNormalFilter(_icon);
         }
         else
         {
            grayFilter.setGrayFilter(_icon);
         }
      }
      
      public function refreshView() : void
      {
         var _loc1_:GoodsInfo = null;
         NumberViewUtils.refreshValue(model.selectedChapter,spNum1,numBitmap,13,15,9,13,"0123456789");
         NumberViewUtils.refreshValue(nodeNum,spNum2,numBitmap,13,15,9,13,"0123456789");
         model.selectedChapter >= 10 ? (spNum1.x = 30) : (spNum1.x = 38);
         isBoss = false;
         if(nodeNum == 5 || nodeNum == 10)
         {
            isBoss = true;
         }
         spNum1.visible = spNum2.visible = line.visible = !isBoss;
         template = TempleteManager.instance.demonLandTemplateCate.getTemplateByChapterAndNodeId(model.selectedChapter,nodeNum);
         var _loc3_:Array = TempleteManager.instance.demonLandDropTemplateCate.getTemplatesByDropId(template.FirstDropId);
         var _loc2_:int = int((_loc3_[0] as DemonLandDropTemplate).ItemId);
         if(_loc2_)
         {
            _loc1_ = new GoodsInfo();
            _loc1_.templateId = _loc2_;
            _loc1_.count = (_loc3_[0] as DemonLandDropTemplate).Count;
            goodsItem.data = _loc1_;
         }
         else
         {
            goodsItem.data = null;
         }
         if(isBoss)
         {
            _icon.setFrame(4);
            _loc3_ = TempleteManager.instance.demonLandDropTemplateCate.getTemplatesByDropId(template.AttackDropId);
            _loc2_ = int((_loc3_[0] as DemonLandDropTemplate).ItemId);
            if(_loc2_)
            {
               _loc1_ = new GoodsInfo();
               bossItem.visible = true;
               _loc1_.templateId = _loc2_;
               _loc1_.count = (_loc3_[0] as DemonLandDropTemplate).Count;
               bossItem.data = _loc1_;
            }
            else
            {
               bossItem.data = null;
            }
         }
      }
      
      private function addEvent() : void
      {
         if(_icon)
         {
            _icon.addEventListener("click",onClickIcon);
            _icon.addEventListener("rollOver",onOverIcon);
            _icon.addEventListener("rollOut",onOutIcon);
         }
      }
      
      private function removeEvent() : void
      {
         if(_icon)
         {
            _icon.removeEventListener("click",onClickIcon);
            _icon.removeEventListener("rollOver",onOverIcon);
            _icon.removeEventListener("rollOut",onOutIcon);
         }
      }
      
      protected function onClickIcon(param1:MouseEvent) : void
      {
         if(myState == 1)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("demonland.main.text3"));
            return;
         }
         if(!isBoss)
         {
            _icon.setFrame(3);
         }
         model.selectedNode = nodeNum;
         FrameControllerManager.instance.openControllerByInfo("demonland",3);
      }
      
      protected function onOutIcon(param1:MouseEvent) : void
      {
         filters = _lightFilter[0];
      }
      
      protected function onOverIcon(param1:MouseEvent) : void
      {
         filters = _lightFilter[1];
      }
      
      private function get model() : DemonLandModel
      {
         return DemonLandManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         template = null;
         grayFilter = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(goodsItem);
         goodsItem = null;
         ObjectUtils.disposeObject(bossItem);
         bossItem = null;
         ObjectUtils.disposeObject(line);
         line = null;
         ObjectUtils.disposeObject(numBitmap);
         numBitmap = null;
         ObjectUtils.disposeObject(spNum1);
         spNum1 = null;
         ObjectUtils.disposeObject(spNum2);
         spNum2 = null;
         super.dispose();
      }
   }
}

