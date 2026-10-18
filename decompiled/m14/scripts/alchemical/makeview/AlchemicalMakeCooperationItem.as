package alchemical.makeview
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.alchemical.AlchemicalMakeFormulaInfo;
   import mvc.module.alchemical.AlchemicalModel;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.PlayerEvent;
   import yishi.manager.AlchemicalManager;
   import yishi.manager.PlayerManager;
   
   public class AlchemicalMakeCooperationItem extends Component
   {
      
      private var back:Bitmap;
      
      private var selectBack:ScaleBitmapImage;
      
      private var formulaName:FilterFrameText;
      
      private var joinName:FilterFrameText;
      
      private var processText:FilterFrameText;
      
      private var catalystImage:ScaleFrameImage;
      
      private var leftTime:FilterFrameText;
      
      private var inviteText:FilterFrameText;
      
      private var _data:AlchemicalMakeFormulaInfo;
      
      private var _selected:Boolean;
      
      public function AlchemicalMakeCooperationItem()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatBitmap("asset.AlchemicalMakeCooperationItem.back");
         selectBack = ComponentFactory.Instance.creatComponentByStylename("AlchemicalMakeCooperationItem.selectBack");
         formulaName = ComponentFactory.Instance.creatComponentByStylename("AlchemicalMakeCooperationItem.formulaName");
         joinName = ComponentFactory.Instance.creatComponentByStylename("AlchemicalMakeCooperationItem.joinName");
         processText = ComponentFactory.Instance.creatComponentByStylename("AlchemicalMakeCooperationItem.processText");
         catalystImage = ComponentFactory.Instance.creatComponentByStylename("AlchemicalMakeCooperationItem.catalystImage");
         leftTime = ComponentFactory.Instance.creatComponentByStylename("AlchemicalMakeCooperationItem.leftTime");
         inviteText = ComponentFactory.Instance.creatComponentByStylename("AlchemicalMakeCooperationItem.inviteText");
         addChild(back);
         addChild(selectBack);
         addChild(formulaName);
         addChild(joinName);
         addChild(processText);
         addChild(catalystImage);
         catalystImage.visible = false;
         addChild(leftTime);
         addChild(inviteText);
         inviteText.htmlText = LanguageMgr.GetTranslation("AlchemicalMakeCooperationItem.inviteText.text");
         inviteText.mouseEnabled = true;
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__selectFormulaChange);
         inviteText.addEventListener("click",__inviteClickHandler);
         playerModel.addEventListener("SYSTIME_UPGRADE_SECOND",__timeSecondHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__selectFormulaChange);
         if(inviteText)
         {
            inviteText.removeEventListener("click",__inviteClickHandler);
         }
         playerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",__timeSecondHandler);
      }
      
      private function __inviteClickHandler(param1:MouseEvent) : void
      {
         if(!data)
         {
            return;
         }
         AlchemicalManager.instance.sendAlchemicalSharedInvite(data.shareUid);
      }
      
      private function __selectFormulaChange(param1:MouseEvent) : void
      {
         model.selectFormulaInfo = data;
      }
      
      private function __timeSecondHandler(param1:PlayerEvent) : void
      {
         if(!data)
         {
            return;
         }
         leftTime.text = LanguageMgr.GetTranslation("emailII.view.EmailItemView.leftTime",data.formulaLeftTime);
      }
      
      public function get data() : AlchemicalMakeFormulaInfo
      {
         return _data;
      }
      
      public function set data(param1:AlchemicalMakeFormulaInfo) : void
      {
         _data = param1;
         refreshView();
      }
      
      private function refreshView() : void
      {
         if(data)
         {
            formulaName.text = LanguageMgr.GetTranslation("Alchemical.chatInvite.text" + data.tempInfo.RewardType) + "-" + data.tempInfo.Name;
            joinName.text = data.allName;
            processText.text = LanguageMgr.GetTranslation("AlchemicalMakeCooperationItem.processText.text",data.childFormulaList.length,data.stepCount);
            leftTime.text = LanguageMgr.GetTranslation("emailII.view.EmailItemView.leftTime",data.formulaLeftTime);
            inviteText.htmlText = LanguageMgr.GetTranslation("AlchemicalMakeCooperationItem.inviteText.text");
            inviteText.visible = data.isSelfJoin;
            catalystImage.visible = data.casalystCount > 0;
            catalystImage.setFrame(data.casalystCount);
            catalystImage.x = processText.x + processText.textWidth + 5;
         }
         else
         {
            selectBack.visible = false;
            formulaName.text = "";
            joinName.text = "";
            processText.text = "";
            leftTime.text = "";
            inviteText.text = "";
            inviteText.visible = false;
            catalystImage.visible = false;
         }
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         selectBack.visible = selected;
      }
      
      private function get model() : AlchemicalModel
      {
         return AlchemicalManager.instance.model;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(selectBack);
         selectBack = null;
         ObjectUtils.disposeObject(formulaName);
         formulaName = null;
         ObjectUtils.disposeObject(joinName);
         joinName = null;
         ObjectUtils.disposeObject(processText);
         processText = null;
         ObjectUtils.disposeObject(leftTime);
         leftTime = null;
         ObjectUtils.disposeObject(inviteText);
         inviteText = null;
         ObjectUtils.disposeObject(catalystImage);
         catalystImage = null;
         super.dispose();
      }
   }
}

