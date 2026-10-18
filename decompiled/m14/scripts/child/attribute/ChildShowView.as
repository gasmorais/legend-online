package child.attribute
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.children.ChildData;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.view.frame.BuyFrameI;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildShowView extends Component
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _figure:ChildShowAvatar;
      
      private var _jobImage:ScaleFrameImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _gradeTxt:FilterFrameText;
      
      private var _jobTxt:FilterFrameText;
      
      private var _changeBtn:TextButton;
      
      private var _data:ChildData;
      
      private var _fosterView:ChildFosterViewII;
      
      private var _childThane:ThaneInfo;
      
      private var showType:int;
      
      private var _renameView:ChildRenameView;
      
      public function ChildShowView(param1:int)
      {
         super();
         showType = param1;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ChildShowView.bg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("ChildShowView.nameTxt");
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("ChildShowView.gradeTxt");
         _jobTxt = ComponentFactory.Instance.creatComponentByStylename("ChildShowView.jobTxt");
         _changeBtn = ComponentFactory.Instance.creatComponentByStylename("ChildShowView.changeBtn");
         _jobImage = ComponentFactory.Instance.creatComponentByStylename("ChildItemView.jobImageBig");
         _fosterView = new ChildFosterViewII(showType);
         _figure = new ChildShowAvatar();
         addChild(_bg);
         addChild(_figure);
         addChild(_changeBtn);
         addChild(_nameTxt);
         _nameTxt.width = 200;
         addChild(_gradeTxt);
         addChild(_jobTxt);
         addChild(_fosterView);
         _figure.x = 50;
         _figure.y = 62;
         _jobImage.x = 323;
         _jobImage.y = 14;
         _figure.mouseChildren = _figure.mouseEnabled = false;
         _changeBtn.text = LanguageMgr.GetTranslation("child.ChildShowView.changeTxt");
      }
      
      public function set data(param1:ChildData) : void
      {
         if(param1 == null || param1.state == -1)
         {
            return;
         }
         _data = param1;
         refreshView();
      }
      
      private function refreshView() : void
      {
         if(_data == null || _data.state == -1)
         {
            return;
         }
         if(_fosterView)
         {
            _fosterView.data = _data;
            _fosterView.visible = _data.state == 1;
         }
         if(_data.state == 0)
         {
            _bg.setFrame(_data.sex + 1);
         }
         else if(_data.state == 1)
         {
            if(_data.job > 0)
            {
               _bg.setFrame(4);
            }
            else
            {
               _bg.setFrame(4);
            }
         }
         _nameTxt.text = _data.name;
         var _loc1_:ChildTempInfo = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_data.job,_data.growthGrade);
         var _loc2_:String = _loc1_.JobName;
         _jobTxt.text = _loc2_;
         if(_data.nursingSpiritInfo && _data.nursingSpiritInfo.trainInfo.clientFlg == 1)
         {
            _gradeTxt.htmlText = LanguageMgr.GetTranslation("ChildHandBookItem.gradeText.text2",_data.nursingSpiritInfo.trainInfo.grade);
         }
         else
         {
            _gradeTxt.text = LanguageMgr.GetTranslation("public.level2",_data.growthGrade);
         }
         _figure.data = _data;
         setHeadIcon();
      }
      
      private function setHeadIcon() : void
      {
         _jobImage.setFrame(_data.job);
         _jobImage.tipData = LanguageMgr.GetTranslation("yishi.datas.consant.JobType.Name0" + (_data.job + 1));
      }
      
      private function initEvent() : void
      {
         if(_changeBtn)
         {
            _changeBtn.addEventListener("click",__changeHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_changeBtn)
         {
            _changeBtn.removeEventListener("click",__changeHandler);
         }
      }
      
      private function __changeHandler(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         if(_data.fightUserId > 0 && _data.fightUserId != playerInfo.userId)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.cannotop"));
            return;
         }
         if(_renameView)
         {
            _renameView.dispose();
            _renameView = null;
         }
         var _loc2_:int = int(GoodsManager.instance.findPosById(208043));
         if(_loc2_ < 0)
         {
            CheckUIModuleUtil.instance.tryCall("quickbuy",showBuyFrameCall);
            return;
         }
         _renameView = ComponentFactory.Instance.creatComponentByStylename("ChildShowView.PetRenameFrame");
         _renameView.data = _data;
         _renameView.show();
      }
      
      private function showBuyFrameCall() : void
      {
         var _loc1_:BuyFrameI = ComponentFactory.Instance.creatComponentByStylename("quickbuy.buyFrame");
         var _loc2_:ShopGoodsInfo = TempleteManager.instance.getShopTempInfoByItemId(208043);
         if(_loc2_ == null)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.attribute.ChildShowView.NoRenameCard"));
            return;
         }
         _loc1_.data(_loc2_,1);
         _loc1_.show();
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_figure);
         _figure = null;
         ObjectUtils.disposeObject(_changeBtn);
         _changeBtn = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_gradeTxt);
         _gradeTxt = null;
         ObjectUtils.disposeObject(_jobTxt);
         _gradeTxt = null;
         ObjectUtils.disposeObject(_fosterView);
         _fosterView = null;
         ObjectUtils.disposeObject(_renameView);
         _renameView = null;
         ObjectUtils.disposeObject(_jobImage);
         _jobImage = null;
         _data = null;
         _childThane = null;
         super.dispose();
      }
   }
}

