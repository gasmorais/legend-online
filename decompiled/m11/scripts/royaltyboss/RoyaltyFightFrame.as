package royaltyboss
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.royaltyboss.RoyaltyBossModel;
   import mvc.module.theseus.TheseussoulModel;
   import yishi.SwitchPageHelp;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.RoyaltyBossTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.RoyaltyBossManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class RoyaltyFightFrame extends Frame implements IManualSize
   {
      
      private var _bg:Bitmap;
      
      private var _item:RoyaltyBossItem;
      
      private var _fightImg:Bitmap;
      
      private var _armorImg:Bitmap;
      
      private var _fightTxt:FilterFrameText;
      
      private var _armorTxt:FilterFrameText;
      
      private var _conditionTxt:FilterFrameText;
      
      private var _back:Bitmap;
      
      private var _rewardsImg:Bitmap;
      
      private var _pointImg:Bitmap;
      
      private var _descTxt:FilterFrameText;
      
      private var _armorBtn:IconButton;
      
      private var _fightBtn:IconButton;
      
      private var _rewardsHBox:HBox;
      
      private var _rewardsPanel:ScrollPanel;
      
      public function RoyaltyFightFrame()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,383,413);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("royaltyFightFrame.titleText");
         _bg = ComponentFactory.Instance.creatBitmap("asset.RoyaltyFightFrame.bg");
         _fightImg = ComponentFactory.Instance.creatBitmap("asset.RoyaltyFightFrame.theseusFight");
         _armorImg = ComponentFactory.Instance.creatBitmap("asset.RoyaltyFightFrame.theseusArmor");
         _fightTxt = ComponentFactory.Instance.creatComponentByStylename("royaltyFightFrame.fightTxt");
         _armorTxt = ComponentFactory.Instance.creatComponentByStylename("royaltyFightFrame.armorTxt");
         _conditionTxt = ComponentFactory.Instance.creatComponentByStylename("royaltyFightFrame.conditionTxt");
         _back = ComponentFactory.Instance.creatBitmap("asset.RoyaltyFightFrame.back");
         _rewardsImg = ComponentFactory.Instance.creatBitmap("asset.RoyaltyFightFrame.rewardsImg");
         _pointImg = ComponentFactory.Instance.creatBitmap("asset.RoyaltyPropertyItem.icon");
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("royaltyFightFrame.descTxt");
         _armorBtn = ComponentFactory.Instance.creatComponentByStylename("royaltyFightFrame.armorBtn");
         _fightBtn = ComponentFactory.Instance.creatComponentByStylename("royaltyFightFrame.fightBtn");
         _rewardsHBox = ComponentFactory.Instance.creatComponentByStylename("royaltyFightFrame.RewardsHBox");
         _rewardsPanel = ComponentFactory.Instance.creatComponentByStylename("royaltyFightFrame.panel");
         addToContent(_bg);
         addToContent(_armorImg);
         addToContent(_armorTxt);
         addToContent(_conditionTxt);
         addToContent(_back);
         addToContent(_rewardsImg);
         addToContent(_pointImg);
         addToContent(_descTxt);
         addToContent(_armorBtn);
         addToContent(_fightBtn);
         addToContent(_rewardsPanel);
         _rewardsPanel.setView(_rewardsHBox);
         _pointImg.x = 20;
         _pointImg.y = 235;
         _item = new RoyaltyBossItem(0);
         _item.data = royaltyBossTempInfo;
         _item.x = 25;
         _item.y = 15;
         addToContent(_item);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _armorBtn.addEventListener("click",__armorBtnClickHandler);
         _fightBtn.addEventListener("click",__fightBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _armorBtn.removeEventListener("click",__armorBtnClickHandler);
         _fightBtn.removeEventListener("click",__fightBtnClickHandler);
      }
      
      private function __armorBtnClickHandler(param1:MouseEvent) : void
      {
         SwitchPageHelp.openPoseidonFrame();
      }
      
      private function __fightBtnClickHandler(param1:MouseEvent) : void
      {
         RoyaltyBossManager.instance.sendFight();
      }
      
      public function refreshView() : void
      {
         var _loc5_:GoodsInfo = null;
         var _loc2_:BaseItemView = null;
         var _loc6_:int = 0;
         var _loc4_:Array = null;
         _fightTxt.text = royaltyBossTempInfo.SoulValue.toString();
         _armorTxt.text = royaltyBossTempInfo.ArmourValue.toString();
         if(theseussoulModel.propertys.armour >= royaltyBossTempInfo.ArmourValue)
         {
            _armorTxt.setFrame(2);
         }
         else
         {
            _armorTxt.setFrame(1);
         }
         var _loc3_:SkillTempInfo = TempleteManager.instance.skillTemplateDic[royaltyBossTempInfo.BossSkill];
         if(_loc3_)
         {
            _conditionTxt.text = LanguageMgr.GetTranslation("apex.team.str13",_loc3_.Description);
         }
         _descTxt.text = LanguageMgr.GetTranslation("royaltyFightFrame.descTxt.text");
         _rewardsHBox.removeAllChild();
         var _loc1_:Array = royaltyBossTempInfo.DropItem.split("|");
         _rewardsHBox.beginChanges();
         _loc6_ = 0;
         while(_loc6_ < _loc1_.length)
         {
            _loc4_ = _loc1_[_loc6_].split(",");
            _loc2_ = ComponentFactory.Instance.creatCustomObject("core.BaseItemView");
            _loc5_ = new GoodsInfo();
            _loc5_.templateId = _loc4_[0];
            _loc5_.count = _loc4_[1];
            _loc2_.data = _loc5_;
            _rewardsHBox.addChild(_loc2_);
            _loc6_++;
         }
         _rewardsHBox.commitChanges();
         _rewardsPanel.invalidateViewport();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get royaltyBossTempInfo() : RoyaltyBossTempInfo
      {
         return TempleteManager.instance.royaltyBossTempCate.getTempInfoByLevel(model.passBossLevel + 1);
      }
      
      private function get model() : RoyaltyBossModel
      {
         return RoyaltyBossManager.instance.model;
      }
      
      private function get theseussoulModel() : TheseussoulModel
      {
         return TheseussoulManager.Instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_item);
         _item = null;
         ObjectUtils.disposeObject(_fightImg);
         _fightImg = null;
         ObjectUtils.disposeObject(_armorImg);
         _armorImg = null;
         ObjectUtils.disposeObject(_fightTxt);
         _fightTxt = null;
         ObjectUtils.disposeObject(_armorTxt);
         _armorTxt = null;
         ObjectUtils.disposeObject(_conditionTxt);
         _conditionTxt = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_rewardsImg);
         _rewardsImg = null;
         ObjectUtils.disposeObject(_pointImg);
         _pointImg = null;
         ObjectUtils.disposeObject(_descTxt);
         _descTxt = null;
         ObjectUtils.disposeObject(_armorBtn);
         _armorBtn = null;
         ObjectUtils.disposeObject(_fightBtn);
         _fightBtn = null;
         ObjectUtils.disposeAllChildren(_rewardsHBox);
         _rewardsHBox = null;
         ObjectUtils.disposeObject(_rewardsPanel);
         _rewardsPanel = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

