package oldplayerreturn.alliance
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.allianceregression.AllyData;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.oldplayerreturn.OldPlayerReturnModel;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.OldPlayerReturnManager;
   import yishi.view.base.ProgressPanel;
   
   public class OldPlayerReturnContractView extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _allianceExpTxt:FilterFrameText;
      
      private var _oracleExpTxt:FilterFrameText;
      
      private var _txtBack:Bitmap;
      
      private var _txt:FilterFrameText;
      
      private var _contractMc:MovieClip;
      
      private var _returneeTxt:FilterFrameText;
      
      private var _eternalTxt:FilterFrameText;
      
      private var _returneeExpTxt:FilterFrameText;
      
      private var _eternalExpTxt:FilterFrameText;
      
      private var _levelTxt:FilterFrameText;
      
      private var _btn:IconButton;
      
      private var _contractExpTxt:FilterFrameText;
      
      private var _progress:ProgressPanel;
      
      private var _sprite:Sprite;
      
      private var _returneeItem:OldPlayerReturnHeadItem;
      
      private var _eternalItem:OldPlayerReturnHeadItem;
      
      public function OldPlayerReturnContractView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.OldPlayerReturnAllianceView.rightBg1");
         _allianceExpTxt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnAllianceView.allianceExpTxt");
         _oracleExpTxt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnAllianceView.oracleExpTxt");
         _txtBack = ComponentFactory.Instance.creatBitmap("asset.OldPlayerReturnAllianceView.txtBack");
         _txt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnAllianceView.txt");
         _contractMc = ComponentFactory.Instance.creatCustomObject("oldPlayerReturnAllianceView.contractMc");
         _returneeTxt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnContractView.returneeTxt");
         _eternalTxt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnContractView.eternalTxt");
         _returneeExpTxt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnContractView.returneeExpTxt");
         _eternalExpTxt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnContractView.eternalExpTxt");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnContractView.levelTxt");
         _btn = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnContractView.btn");
         _contractExpTxt = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnContractView.contractExpTxt");
         _progress = ComponentFactory.Instance.creatCustomObject("oldPlayerReturnContractView.progress");
         addChild(_bg);
         addChild(_allianceExpTxt);
         addChild(_oracleExpTxt);
         addChild(_txtBack);
         addChild(_txt);
         _sprite = new Sprite();
         addChild(_sprite);
         _sprite.addChild(_contractMc);
         _sprite.addChild(_returneeTxt);
         _sprite.addChild(_eternalTxt);
         _sprite.addChild(_returneeExpTxt);
         _sprite.addChild(_eternalExpTxt);
         _sprite.addChild(_levelTxt);
         _sprite.addChild(_btn);
         _sprite.addChild(_contractExpTxt);
         _sprite.addChild(_progress);
         _txt.text = LanguageMgr.GetTranslation("oldPlayerReturnContractView.txt.text");
         _returneeTxt.text = LanguageMgr.GetTranslation("oldPlayerReturnContractView.returneeTxt.text");
         _eternalTxt.text = LanguageMgr.GetTranslation("oldPlayerReturnContractView.eternalTxt.text");
         _contractExpTxt.text = LanguageMgr.GetTranslation("oldPlayerReturnContractView.contractExpTxt.text");
         _progress.initView("oldPlayerReturnContractView.proBack","oldPlayerReturnContractView.proBar","oldPlayerReturnContractView.proTxt");
         _progress.barPosxy(4,4);
         _returneeItem = new OldPlayerReturnHeadItem();
         _returneeItem.x = 45;
         _returneeItem.y = 105;
         _sprite.addChild(_returneeItem);
         _eternalItem = new OldPlayerReturnHeadItem();
         _eternalItem.x = 345;
         _eternalItem.y = 105;
         _sprite.addChild(_eternalItem);
      }
      
      private function addEvent() : void
      {
         _btn.addEventListener("click",__btnClickHandler);
      }
      
      private function removeEvent() : void
      {
         _btn.removeEventListener("click",__btnClickHandler);
      }
      
      private function __btnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("oldplayerreturn",2);
      }
      
      public function refreshView() : void
      {
         _oracleExpTxt.text = LanguageMgr.GetTranslation("oldPlayerReturnContractView.oracleExpTxt.text",model.oracleExp);
         var _loc1_:int = 0;
         if(!data)
         {
            _txtBack.visible = true;
            _txt.visible = true;
            _sprite.visible = false;
         }
         else
         {
            _txtBack.visible = false;
            _txt.visible = false;
            _sprite.visible = true;
            _loc1_ = int(data.myAllianceExp);
            if(model.isReturnPlayer)
            {
               _returneeExpTxt.htmlText = LanguageMgr.GetTranslation("oldPlayerReturnContractView.returneeExpTxt.htmlText",data.myContractExp);
               _eternalExpTxt.htmlText = LanguageMgr.GetTranslation("oldPlayerReturnContractView.returneeExpTxt.htmlText",data.allyContractExp);
            }
            else
            {
               _returneeExpTxt.htmlText = LanguageMgr.GetTranslation("oldPlayerReturnContractView.returneeExpTxt.htmlText",data.allyContractExp);
               _eternalExpTxt.htmlText = LanguageMgr.GetTranslation("oldPlayerReturnContractView.returneeExpTxt.htmlText",data.myContractExp);
            }
            _levelTxt.text = data.contractLevel.toString();
            _progress.progressValue(data.contractCurExp,data.contractNeedExp);
            if(model.isReturnPlayer)
            {
               _returneeItem.refreshSelf();
               _eternalItem.data = data.player;
               _eternalItem.isBinding = data.isBinding;
            }
            else
            {
               _returneeItem.data = data.player;
               _returneeItem.isBinding = data.isBinding;
               _eternalItem.refreshSelf();
            }
         }
         _allianceExpTxt.text = LanguageMgr.GetTranslation("oldPlayerReturnContractView.allianceExpTxt.text",_loc1_);
      }
      
      private function get data() : AllyData
      {
         return model.selectedAllydata;
      }
      
      private function get model() : OldPlayerReturnModel
      {
         return OldPlayerReturnManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_allianceExpTxt);
         _allianceExpTxt = null;
         ObjectUtils.disposeObject(_oracleExpTxt);
         _oracleExpTxt = null;
         ObjectUtils.disposeObject(_txtBack);
         _txtBack = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeViolentMc(_contractMc);
         _contractMc = null;
         ObjectUtils.disposeObject(_returneeTxt);
         _returneeTxt = null;
         ObjectUtils.disposeObject(_eternalTxt);
         _eternalTxt = null;
         ObjectUtils.disposeObject(_returneeExpTxt);
         _returneeExpTxt = null;
         ObjectUtils.disposeObject(_eternalExpTxt);
         _eternalExpTxt = null;
         ObjectUtils.disposeObject(_levelTxt);
         _levelTxt = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_contractExpTxt);
         _contractExpTxt = null;
         ObjectUtils.disposeObject(_progress);
         _progress = null;
         ObjectUtils.disposeObject(_returneeItem);
         _returneeItem = null;
         ObjectUtils.disposeObject(_eternalItem);
         _eternalItem = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

