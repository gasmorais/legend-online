package child.nursingspirit
{
   import child.attribute.ChildNsBuffShowSkView;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.ModuleFrameInfo;
   import mvc.module.avenger.AvengerChildNsInfo;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildSender;
   import mvc.module.theseus.AttributeUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildNsUpBuffFrame extends Frame
   {
      
      private var _bg:Scale9CornerImage;
      
      private var _fmSKTitle:Bitmap;
      
      private var _fmProTtitle:Bitmap;
      
      private var _fmProLvTxt:FilterFrameText;
      
      private var _fmDesTxt:FilterFrameText;
      
      private var _fmShowSkView:ChildNsBuffShowSkView;
      
      private var _fmShowbg:ScaleBitmapImage;
      
      private var _fmProBg:ScaleBitmapImage;
      
      private var _currLearnSk:SkillTempInfo;
      
      private var _idx:int;
      
      private var _chData:ChildData;
      
      private var _upBtn:IconButton;
      
      private var _upMtIcon:BaseIconView;
      
      private var _upMtTxt:FilterFrameText;
      
      private var _refreshBtn:IconButton;
      
      private var _refreshMtIcon:BaseIconView;
      
      private var _refreshMtTxt:FilterFrameText;
      
      private const UP_MT_ID:int = 208528;
      
      private const REFRESH_MT_ID:int = 208529;
      
      private var UP_Needs:Array = [];
      
      private var UP_Refresh:int = 0;
      
      private var _buffLvMax:Array = [1,1,1,1,1];
      
      private var _currBuffSkTemp:SkillTempInfo;
      
      private var _buffIconBg:Image;
      
      private var _buffIcon:BaseIconView;
      
      public function ChildNsUpBuffFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc3_:String = null;
         var _loc2_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("child_skill_upgrade");
         if(_loc2_)
         {
            _loc3_ = _loc2_.ConfigValue;
            UP_Needs = _loc3_.split(",");
         }
         var _loc1_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("child_skill_refresh");
         if(_loc1_)
         {
            UP_Refresh = int(_loc1_.ConfigValue);
         }
         _bg = ComponentFactory.Instance.creatComponentByStylename("childnsUpbuff.bg");
         _fmShowbg = ComponentFactory.Instance.creatComponentByStylename("childnsUpbuff.learnSKbg");
         _fmSKTitle = ComponentFactory.Instance.creatBitmap("asset.ChildNursingSpirit.ns.buffToSk");
         _fmShowSkView = ComponentFactory.Instance.creatCustomObject("ChildNursingSpirit.buffShowView");
         _fmProBg = ComponentFactory.Instance.creatComponentByStylename("childnsUpbuff.buffKbg");
         _fmProTtitle = ComponentFactory.Instance.creatBitmap("asset.ChildNursingSpirit.ns.buffPro");
         _fmProLvTxt = ComponentFactory.Instance.creatComponentByStylename("childnsUpbuff.proLvTxt");
         _fmDesTxt = ComponentFactory.Instance.creatComponentByStylename("childnsUpbuff.proDesTxt");
         _upBtn = ComponentFactory.Instance.creatComponentByStylename("childnsUpbuff.upGradeBtn");
         _upMtIcon = ComponentFactory.Instance.creatCustomObject("childnsUpbuff.upGradeIcon");
         _upMtTxt = ComponentFactory.Instance.creatComponentByStylename("childnsUpbuff.upGradeTxt");
         _refreshBtn = ComponentFactory.Instance.creatComponentByStylename("childnsUpbuff.refreshBtn");
         _refreshMtIcon = ComponentFactory.Instance.creatCustomObject("childnsUpbuff.refreshIcon");
         _refreshMtTxt = ComponentFactory.Instance.creatComponentByStylename("childnsUpbuff.refreshTxt");
         _buffIconBg = ComponentFactory.Instance.creatComponentByStylename("ChildNsUpBuffFrame.fmskBg");
         _buffIcon = ComponentFactory.Instance.creatCustomObject("ChildNSSkillItemView.fmBuffskillItem");
         addToContent(_bg);
         addToContent(_fmShowbg);
         addToContent(_fmSKTitle);
         addToContent(_fmShowSkView);
         addToContent(_fmProBg);
         addToContent(_buffIconBg);
         addToContent(_buffIcon);
         addToContent(_fmProTtitle);
         addToContent(_fmProLvTxt);
         addToContent(_fmDesTxt);
         addToContent(_upBtn);
         addToContent(_upMtIcon);
         addToContent(_upMtTxt);
         addToContent(_refreshBtn);
         addToContent(_refreshMtIcon);
         addToContent(_refreshMtTxt);
         var _loc4_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208528);
         if(_loc4_)
         {
            _upMtIcon.icon = IconFactory.getGoodsIconByTID(208528);
            _upMtIcon.tipData = _loc4_.TemplateName + "\n" + _loc4_.Description;
         }
         _loc4_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208529);
         if(_loc4_)
         {
            _refreshMtIcon.icon = IconFactory.getGoodsIconByTID(208529);
            _refreshMtIcon.tipData = _loc4_.TemplateName + "\n" + _loc4_.Description;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         MsgMan.addObserver("ChildEvent.CHILD_NSINFO_UPDATE",this,upChangeHandler);
         _upBtn.addEventListener("click",upClickHandler);
         _refreshBtn.addEventListener("click",refreshClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         MsgMan.removeObserver("ChildEvent.CHILD_NSINFO_UPDATE",this,upChangeHandler);
         _upBtn.removeEventListener("click",upClickHandler);
         _refreshBtn.removeEventListener("click",refreshClickHandler);
      }
      
      private function upClickHandler(param1:MouseEvent) : void
      {
         if(!_currBuffSkTemp)
         {
            return;
         }
         var _loc2_:int = int(_buffLvMax[_idx]);
         if(_loc2_ <= _currBuffSkTemp.Grades)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("childNsBuffFrame.maxText.text"));
            return;
         }
         if(_idx == 4 && _currBuffSkTemp.Grades >= 4 && _chData.nursingSpiritInfo.trainInfo.profileGrade < 5)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("childnsFm.Max5.tip"));
            return;
         }
         ChildSender.nsTrainOp(48,_chData.childId,_idx);
      }
      
      private function refreshClickHandler(param1:MouseEvent) : void
      {
         ChildSender.nsTrainOp(49,_chData.childId,_idx);
      }
      
      private function upChangeHandler(param1:String, param2:Object) : void
      {
         refreshBuffView();
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
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_fmShowbg);
         _fmShowbg = null;
         ObjectUtils.disposeObject(_fmSKTitle);
         _fmSKTitle = null;
         ObjectUtils.disposeObject(_fmShowSkView);
         _fmShowSkView = null;
         ObjectUtils.disposeObject(_fmProBg);
         _fmProBg = null;
         ObjectUtils.disposeObject(_fmProTtitle);
         _fmProTtitle = null;
         ObjectUtils.disposeObject(_fmProLvTxt);
         _fmProLvTxt = null;
         ObjectUtils.disposeObject(_fmDesTxt);
         _fmDesTxt = null;
         ObjectUtils.disposeObject(_upBtn);
         _upBtn = null;
         ObjectUtils.disposeObject(_upMtIcon);
         _upMtIcon = null;
         ObjectUtils.disposeObject(_upMtTxt);
         _upMtTxt = null;
         ObjectUtils.disposeObject(_refreshBtn);
         _refreshBtn = null;
         ObjectUtils.disposeObject(_refreshMtIcon);
         _refreshMtIcon = null;
         ObjectUtils.disposeObject(_refreshMtTxt);
         _refreshMtTxt = null;
         ObjectUtils.disposeObject(_buffIconBg);
         _buffIconBg = null;
         ObjectUtils.disposeObject(_buffIcon);
         _buffIcon = null;
         super.dispose();
         _chData = null;
         _currBuffSkTemp = null;
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         titleText = LanguageMgr.GetTranslation("childNsBuffFrame.title");
         var _loc2_:Array = param1.frameData as Array;
         _idx = _loc2_[0];
         _chData = _loc2_[1];
         _fmShowSkView.showIdx(_idx,_chData);
         refreshBuffView();
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function refreshBuffView() : void
      {
         var _loc4_:SkillTempInfo = null;
         var _loc2_:int = 0;
         if(!_chData)
         {
            return;
         }
         var _loc7_:int = int(GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(208528));
         var _loc9_:String = _chData.nursingSpiritInfo.trainInfo.skills;
         var _loc3_:Array = _loc9_.split(",");
         var _loc5_:String;
         var _loc6_:int = int(_loc5_ = _loc3_[_idx]);
         if(_loc6_ > 0)
         {
            _currBuffSkTemp = _loc4_ = TempleteManager.instance.getSkillById(_loc6_);
            _fmProLvTxt.text = LanguageMgr.GetTranslation("public.level2",_loc4_.Grades);
            _fmDesTxt.text = _loc4_.Description;
            _buffIcon.icon = IconFactory.getTecIconByIcon(_loc4_.Icons);
            if(!_loc4_.nextTemp)
            {
               _upBtn.enable = false;
            }
            else
            {
               _upBtn.enable = true;
            }
            _loc2_ = int(UP_Needs[_loc4_.Grades - 1]);
            if(_loc7_ >= _loc2_)
            {
               _upMtTxt.text = _loc7_ + "/" + _loc2_;
            }
            else
            {
               _upBtn.enable = false;
               _upMtTxt.htmlText = AttributeUtils.getColorStr("" + _loc7_,"#ff3300") + "/" + _loc2_;
            }
         }
         else
         {
            _currBuffSkTemp = null;
            _upBtn.enable = false;
            _upMtTxt.text = _loc7_ + "/0";
         }
         var _loc1_:int = int(GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(208529));
         if(_loc1_ >= UP_Refresh)
         {
            _refreshMtTxt.text = _loc1_ + "/" + UP_Refresh;
            _refreshBtn.enable = true;
         }
         else
         {
            _refreshBtn.enable = false;
            _refreshMtTxt.htmlText = AttributeUtils.getColorStr("" + _loc1_,"#ff3300") + "/" + UP_Refresh;
         }
         var _loc10_:AvengerChildNsInfo = _chData.nursingSpiritInfo.trainInfo;
         var _loc8_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(_loc10_.grade,156);
         if(_loc8_)
         {
            _buffLvMax = _loc8_.TemplateName.split(",");
         }
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

