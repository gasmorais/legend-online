package chess.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.chess.SelfChessManager;
   import mvc.module.chess.SelfChessPlayerInfo;
   import yishi.datas.templates.SelfChessBuffTempInfo;
   import yishi.datas.templates.SelfChessTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class SelfChessHeroItem extends Component
   {
      
      public var _buyBg:Bitmap;
      
      public var _btHeroNameTxt:FilterFrameText;
      
      public var _btHeroGoldTxt:FilterFrameText;
      
      public var _btHeroIcon:BaseIconView;
      
      public var _btSkillIcon:BaseIconView;
      
      public var _btHeroGold:Image;
      
      public var _btHeroskIcon1:BaseIconView;
      
      public var _btHeroskIcon2:BaseIconView;
      
      private var _tempId:int = -1;
      
      private var _pos:int;
      
      private var _needGold:int;
      
      private var _selectedImg:Bitmap;
      
      private var _profileBit:ScaleFrameImage;
      
      private var _gray:Array;
      
      public function SelfChessHeroItem(param1:int, param2:Bitmap)
      {
         super();
         _pos = param1;
         _selectedImg = param2;
         initView();
         initEvent();
      }
      
      public function set tempId(param1:int) : void
      {
         var _loc6_:SelfChessTempInfo = null;
         var _loc2_:Array = null;
         var _loc7_:SkillTempInfo = null;
         var _loc10_:String = null;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc9_:Array = null;
         var _loc5_:SelfChessBuffTempInfo = null;
         var _loc8_:int = 0;
         if(param1 > 0)
         {
            _loc6_ = TempleteManager.instance.selfChessTempCate.getTempById(param1);
         }
         if(_loc6_)
         {
            if(SelfChessManager.Ins.model.selfInfo && SelfChessManager.Ins.model.selfInfo.gold < _loc6_.Grade)
            {
               this.filters = _gray;
            }
            else
            {
               this.filters = null;
            }
         }
         if(_tempId == param1)
         {
            return;
         }
         _tempId = param1;
         if(_tempId == 0)
         {
            this.visible = false;
         }
         else
         {
            this.visible = true;
            _btHeroIcon.icon = PathManager.solveCampaignMovieByUrl(_loc6_.Icon);
            _loc2_ = _loc6_.SkillScript.split(",");
            _loc7_ = TempleteManager.instance.getSkillTemplateInfoById(int(_loc2_[0]));
            _loc10_ = IconFactory.getTecIconByIcon(_loc7_.Icons);
            _btSkillIcon.icon = _loc10_;
            _btHeroNameTxt.text = _loc6_.TemplateName;
            _needGold = _loc6_.Grade;
            _btHeroGoldTxt.text = "" + _needGold;
            _btHeroIcon.tipData = _loc6_;
            _profileBit.setFrame(_loc6_.Grade);
            _loc3_ = _loc6_.Job.split(",");
            _loc4_ = int(_loc3_[0]);
            if(_loc4_ > 0)
            {
               _loc9_ = TempleteManager.instance.selfChessBuffTempCate.getTempJobList(_loc4_);
               _loc5_ = _loc9_[0];
               _btHeroskIcon1.icon = PathManager.getSelfChessKindIcon(false,_loc4_);
               _btHeroskIcon1.tipData = _loc5_.TemplateName;
            }
            else
            {
               _btHeroskIcon1.icon = null;
            }
            _loc8_ = int(_loc3_[1]);
            if(_loc8_ > 0)
            {
               _loc9_ = TempleteManager.instance.selfChessBuffTempCate.getTempJobList(_loc8_);
               _loc5_ = _loc9_[0];
               _btHeroskIcon2.icon = PathManager.getSelfChessKindIcon(false,_loc8_);
               _btHeroskIcon2.tipData = _loc5_.TemplateName;
            }
            else
            {
               _btHeroskIcon2.icon = null;
            }
         }
      }
      
      private function initView() : void
      {
         _gray = [UIFilter.getGrayFilter()];
         _buyBg = ComponentFactory.Instance.creatBitmap("asset.selfchess.buyBg");
         _btHeroNameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.btHeroNameTxt");
         _btHeroGoldTxt = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.btHeroGoldTxt");
         _btHeroIcon = ComponentFactory.Instance.creatCustomObject("ui.selfchess.btHeroIcon");
         _btSkillIcon = ComponentFactory.Instance.creatCustomObject("ui.selfchess.btSkillIcon");
         _profileBit = ComponentFactory.Instance.creatComponentByStylename("selfchess.iconProfile");
         _btHeroGold = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.btHeroGold");
         _btHeroskIcon1 = ComponentFactory.Instance.creatCustomObject("ui.selfchess.btHeroskIcon1");
         _btHeroskIcon2 = ComponentFactory.Instance.creatCustomObject("ui.selfchess.btHeroskIcon2");
         addChild(_buyBg);
         addChild(_btHeroNameTxt);
         addChild(_btHeroGoldTxt);
         addChild(_btHeroIcon);
         addChild(_btSkillIcon);
         addChild(_profileBit);
         addChild(_btHeroGold);
         addChild(_btHeroskIcon1);
         addChild(_btHeroskIcon2);
         _profileBit.visible = true;
         _profileBit.mouseEnabled = _profileBit.mouseChildren = false;
         this.visible = false;
      }
      
      private function initEvent() : void
      {
         this.addEventListener("click",clickHandler);
         this.addEventListener("rollOver",overHandler);
         this.addEventListener("rollOut",outHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("click",clickHandler);
         this.removeEventListener("rollOver",overHandler);
         this.removeEventListener("rollOut",outHandler);
      }
      
      private function overHandler(param1:MouseEvent) : void
      {
         _selectedImg.visible = true;
         _selectedImg.x = this.x;
         _selectedImg.y = this.y;
      }
      
      private function outHandler(param1:MouseEvent) : void
      {
         _selectedImg.visible = false;
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:SelfChessPlayerInfo = SelfChessManager.Ins.model.selfInfo;
         if(_loc3_)
         {
            _loc2_ = int(_loc3_.gold);
         }
         if(_loc2_ < _needGold)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("selfchess.buy.noGold"));
            return;
         }
         SelfChessManager.Ins.sendOp(3,_pos);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_buyBg);
         _buyBg = null;
         ObjectUtils.disposeObject(_btHeroNameTxt);
         _btHeroNameTxt = null;
         ObjectUtils.disposeObject(_btHeroGoldTxt);
         _btHeroGoldTxt = null;
         ObjectUtils.disposeObject(_btHeroIcon);
         _btHeroIcon = null;
         ObjectUtils.disposeObject(_btSkillIcon);
         _btSkillIcon = null;
         ObjectUtils.disposeObject(_btHeroGold);
         _btHeroGold = null;
         ObjectUtils.disposeObject(_btHeroskIcon1);
         _btHeroskIcon1 = null;
         ObjectUtils.disposeObject(_btHeroskIcon2);
         _btHeroskIcon2 = null;
         ObjectUtils.disposeObject(_profileBit);
         _profileBit = null;
         super.dispose();
         _selectedImg = null;
         _gray = null;
      }
   }
}

