package shadowland
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.shadowland.ShadowLandChapterInfo;
   import mvc.module.shadowland.ShadowLandModel;
   import yishi.datas.templates.ShadowLandTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.ShadowLandManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class ShadowLandNodeItem extends Component
   {
      
      private var _bottom:Bitmap;
      
      private var _selectBg:Bitmap;
      
      private var _nodeBg:Bitmap;
      
      private var _monsterIcon:BaseIconView;
      
      private var _nodeIdText:FilterFrameText;
      
      private var _starBit:Image;
      
      private var _tempInfo:ShadowLandTempInfo;
      
      public function ShadowLandNodeItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bottom = ComponentFactory.Instance.creatBitmap("asset.ShadowLandNodeItem.bottom");
         _selectBg = ComponentFactory.Instance.creatBitmap("asset.ShadowLandNodeItem.selectBg");
         _nodeBg = ComponentFactory.Instance.creatBitmap("asset.ShadowLandNodeItem.nodeBg");
         _monsterIcon = ComponentFactory.Instance.creatCustomObject("shadowLandNodeItem.monsterIcon");
         _starBit = ComponentFactory.Instance.creatComponentByStylename("shadowLandNodeItem.starBit");
         _nodeIdText = ComponentFactory.Instance.creatComponentByStylename("shadowLandNodeItem.nodeIdText");
         addChild(_bottom);
         addChild(_nodeBg);
         addChild(_selectBg);
         addChild(_monsterIcon);
         addChild(_starBit);
         addChild(_nodeIdText);
      }
      
      private function addEvent() : void
      {
         addEventListener("rollOver",__mouseOverHandler);
         addEventListener("rollOut",__mouseOutHandler);
         addEventListener("click",__nodeClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("rollOver",__mouseOverHandler);
         removeEventListener("rollOut",__mouseOutHandler);
         removeEventListener("click",__nodeClickHandler);
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         this.filters = [UIFilter.getLightingFilter()];
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         this.filters = [];
      }
      
      private function __nodeClickHandler(param1:MouseEvent) : void
      {
         if(model.curNum < model.consume)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ShadowLandChapterFrame.noEnergyAlert"));
            return;
         }
         model.tempAreaId = _tempInfo.AreaId;
         model.tempDiff = _tempInfo.Difficulty;
         FrameControllerManager.instance.openControllerByInfo("shadowland",3,_tempInfo);
      }
      
      public function refreshView() : void
      {
         var _loc1_:ShadowLandChapterInfo = model.getChapterInfoByAreaIdDiff(tempInfo.AreaId,tempInfo.Difficulty);
         if(!_loc1_)
         {
            return;
         }
         _selectBg.visible = false;
         this.buttonMode = true;
         this.mouseChildren = this.mouseEnabled = true;
         _starBit.visible = true;
         if(_loc1_.passNodeId < tempInfo.NodeId)
         {
            if(_loc1_.passNodeId + 1 == tempInfo.NodeId)
            {
               this.filters = [];
               _selectBg.visible = true;
            }
            else
            {
               this.filters = [UIFilter.getGrayFilter()];
               this.buttonMode = false;
               this.mouseChildren = this.mouseEnabled = false;
            }
         }
         else
         {
            this.filters = [];
            _starBit.visible = false;
         }
      }
      
      public function get tempInfo() : ShadowLandTempInfo
      {
         return _tempInfo;
      }
      
      public function set tempInfo(param1:ShadowLandTempInfo) : void
      {
         _tempInfo = param1;
         if(!tempInfo)
         {
            return;
         }
         _nodeIdText.text = tempInfo.AreaId + "-" + tempInfo.NodeId;
         if(tempInfo.bossTemp)
         {
            _monsterIcon.icon = IconFactory.getHeroicon(tempInfo.bossTemp.TemplateId);
         }
         else if(tempInfo.npcTemp)
         {
            _monsterIcon.icon = IconFactory.getSoldierIconByIcon(tempInfo.npcTemp.Icon);
         }
         else
         {
            _monsterIcon.icon = null;
         }
      }
      
      private function get model() : ShadowLandModel
      {
         return ShadowLandManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bottom);
         _bottom = null;
         ObjectUtils.disposeObject(_selectBg);
         _selectBg = null;
         ObjectUtils.disposeObject(_nodeBg);
         _nodeBg = null;
         ObjectUtils.disposeObject(_monsterIcon);
         _monsterIcon = null;
         ObjectUtils.disposeObject(_nodeIdText);
         _nodeIdText = null;
         ObjectUtils.disposeObject(_starBit);
         _starBit = null;
         super.dispose();
      }
   }
}

