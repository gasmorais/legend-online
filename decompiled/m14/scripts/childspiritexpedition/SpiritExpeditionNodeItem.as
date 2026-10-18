package childspiritexpedition
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import managers.SpiritExpeditionManager;
   import mvc.module.childspiritexpedition.SpiritExpeditionChapterInfo;
   import mvc.module.childspiritexpedition.SpiritExpeditionModel;
   import yishi.datas.templates.SpiritExpeditionTempInfo;
   import yishi.filter.UIFilter;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class SpiritExpeditionNodeItem extends Component
   {
      
      private var _selectBg:ScaleFrameImage;
      
      private var _nodeBg:ScaleFrameImage;
      
      private var _monsterIcon:BaseIconView;
      
      private var _starBox:HBox;
      
      private var _nodeIdText:FilterFrameText;
      
      private var _bossText:FilterFrameText;
      
      private var _passImage:Bitmap;
      
      private var _tempInfo:SpiritExpeditionTempInfo;
      
      public function SpiritExpeditionNodeItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _selectBg = ComponentFactory.Instance.creatComponentByStylename("SpiritExpeditionNodeItem.selectBg");
         _nodeBg = ComponentFactory.Instance.creatComponentByStylename("SpiritExpeditionNodeItem.nodeBg");
         _monsterIcon = ComponentFactory.Instance.creatCustomObject("SpiritExpeditionNodeItem.monsterIcon");
         _starBox = ComponentFactory.Instance.creatComponentByStylename("SpiritExpeditionNodeItem.starBox");
         _nodeIdText = ComponentFactory.Instance.creatComponentByStylename("SpiritExpeditionNodeItem.nodeIdText");
         _bossText = ComponentFactory.Instance.creatComponentByStylename("SpiritExpeditionNodeItem.bossText");
         _passImage = ComponentFactory.Instance.creatBitmap("asset.SpiritExpeditionNodeItem.passImage");
         addChild(_selectBg);
         addChild(_nodeBg);
         addChild(_monsterIcon);
         addChild(_starBox);
         addChild(_nodeIdText);
         addChild(_bossText);
         addChild(_passImage);
      }
      
      public function get tempInfo() : SpiritExpeditionTempInfo
      {
         return _tempInfo;
      }
      
      public function set tempInfo(param1:SpiritExpeditionTempInfo) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Bitmap = null;
         _tempInfo = param1;
         if(!tempInfo)
         {
            return;
         }
         _nodeIdText.text = tempInfo.AreaId + "-" + tempInfo.NodeId;
         _bossText.text = LanguageMgr.GetTranslation("SpiritExpeditionNodeItem.bossText.text");
         this.tipData = tempInfo;
         if(tempInfo.bossTemp)
         {
            _monsterIcon.icon = IconFactory.getHeroicon(tempInfo.bossTemp.TemplateId);
            _selectBg.setFrame(2);
            _nodeBg.setFrame(2);
            _nodeIdText.text = "";
         }
         else if(tempInfo.npcTemp)
         {
            _monsterIcon.icon = IconFactory.getSoldierIconByIcon(tempInfo.npcTemp.Icon);
            _selectBg.setFrame(1);
            _nodeBg.setFrame(1);
            _bossText.text = "";
         }
         else
         {
            _monsterIcon.icon = null;
         }
         _starBox.removeAllChild();
         _loc3_ = 0;
         while(_loc3_ < tempInfo.Star)
         {
            _loc2_ = ComponentFactory.Instance.creatBitmap("asset.common.lightStar2");
            _starBox.addChild(_loc2_);
            _loc3_++;
         }
      }
      
      public function refreshView() : void
      {
         var _loc1_:SpiritExpeditionChapterInfo = model.getChapterInfoById(tempInfo.AreaId);
         if(!_loc1_)
         {
            return;
         }
         _selectBg.visible = false;
         _passImage.visible = false;
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
            }
         }
         else
         {
            _passImage.visible = true;
            this.filters = [];
         }
      }
      
      private function get model() : SpiritExpeditionModel
      {
         return SpiritExpeditionManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_selectBg);
         _selectBg = null;
         ObjectUtils.disposeObject(_nodeBg);
         _nodeBg = null;
         ObjectUtils.disposeObject(_monsterIcon);
         _monsterIcon = null;
         ObjectUtils.disposeObject(_starBox);
         _starBox = null;
         ObjectUtils.disposeObject(_nodeIdText);
         _nodeIdText = null;
         ObjectUtils.disposeObject(_bossText);
         _bossText = null;
         ObjectUtils.disposeObject(_passImage);
         _passImage = null;
         super.dispose();
      }
   }
}

