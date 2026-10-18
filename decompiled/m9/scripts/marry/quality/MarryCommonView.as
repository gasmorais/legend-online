package marry.quality
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import marry.view.MarryRingView;
   import mvc.module.marry.MarryTipData;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.MarryQualityData;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseItemView;
   
   public class MarryCommonView extends SelectedButton
   {
      
      private var _bg:MutipleImage;
      
      private var _selectedBg:Scale9CornerImage;
      
      private var _nowPrice:GradientText;
      
      private var _blackGound:Sprite;
      
      private var _iconVbox:VBox;
      
      private var _textVbox:VBox;
      
      private var _ringView:MarryRingView;
      
      public function MarryCommonView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("MarryCommonView.bg");
         _nowPrice = ComponentFactory.Instance.creatComponentByStylename("MarryCommonView.nowPrice");
         _selectedBg = ComponentFactory.Instance.creatComponentByStylename("MarryCommonView.selectedBg");
         _iconVbox = ComponentFactory.Instance.creatComponentByStylename("MarryCommonView.iconVbox");
         _textVbox = ComponentFactory.Instance.creatComponentByStylename("MarryCommonView.textVbox");
         if(temp)
         {
            _nowPrice.text = "" + temp.Points;
         }
         _selectedBg.alpha = 0;
         addChildren();
         addBlackMask();
         setHitArea();
         mouseChildren = true;
      }
      
      private function get temp() : MarryQualityData
      {
         return TempleteManager.instance.getMarryQualityTemplateCate.getTempById(3);
      }
      
      private function initReward() : void
      {
         var _loc2_:ThaneInfo = null;
         var _loc4_:BaseItemView = null;
         var _loc3_:MarryTipData = null;
         var _loc1_:FilterFrameText = null;
         if(temp)
         {
            _loc2_ = new ThaneInfo();
            _loc2_.marryRingGrade = temp.RingGrade;
            _ringView = new MarryRingView(_loc2_);
            _ringView.width = 52;
            _ringView.height = 51;
            _iconVbox.addChild(_ringView);
         }
         _loc4_ = ComponentFactory.Instance.creatCustomObject("MarryKiloView.rewardItem");
         if(temp)
         {
            _loc4_.icon.tipStyle = "yishi.view.tips.MarryTip";
            _loc3_ = new MarryTipData();
            _loc3_.type = 3;
            _loc3_.grades = temp.RingGrade;
            _loc4_.icon.tipData = _loc3_;
            _loc4_.icon.icon = IconFactory.getMarrySkillByLevel(temp.RingGrade);
         }
         _iconVbox.addChild(_loc4_);
         _iconVbox.refreshChildPos();
         _loc1_ = ComponentFactory.Instance.creatComponentByStylename("MarryCommonView.rewardTxt");
         _loc1_.text = LanguageMgr.GetTranslation("marry.propose.MarryRewardFrame1.rewardTxt1");
         _textVbox.addChild(_loc1_);
         _loc1_ = ComponentFactory.Instance.creatComponentByStylename("MarryCommonView.rewardTxt");
         _loc1_.text = LanguageMgr.GetTranslation("marry.propose.MarryRewardFrame1.rewardTxt2");
         _textVbox.addChild(_loc1_);
         _textVbox.refreshChildPos();
      }
      
      private function setHitArea() : void
      {
         hitArea = _selectedBg;
      }
      
      private function addBlackMask() : void
      {
         if(_blackGound == null)
         {
            _blackGound = new Sprite();
            _blackGound.graphics.beginFill(0,0.5);
            _blackGound.graphics.drawRect(_selectedBg.x,_selectedBg.y,_selectedBg.width,_selectedBg.height);
            _blackGound.graphics.endFill();
            _blackGound.mouseChildren = false;
            _blackGound.mouseEnabled = false;
            addChild(_blackGound);
         }
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_bg)
         {
            addChild(_bg);
         }
         if(_nowPrice)
         {
            addChild(_nowPrice);
         }
         if(_selectedBg)
         {
            addChild(_selectedBg);
         }
         if(_iconVbox)
         {
            addChild(_iconVbox);
         }
         if(_textVbox)
         {
            addChild(_textVbox);
         }
      }
      
      override public function set selected(param1:Boolean) : void
      {
         super.selected = param1;
         if(_selectedBg)
         {
            _selectedBg.alpha = param1 ? 1 : 0;
         }
         if(_blackGound)
         {
            _blackGound.visible = !param1;
         }
      }
      
      override public function dispose() : void
      {
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_selectedBg)
         {
            _selectedBg.dispose();
         }
         _selectedBg = null;
         if(_nowPrice)
         {
            _nowPrice.dispose();
         }
         _nowPrice = null;
         if(_iconVbox)
         {
            _iconVbox.dispose();
         }
         _iconVbox = null;
         if(_textVbox)
         {
            _textVbox.dispose();
         }
         _textVbox = null;
         if(_blackGound)
         {
            _blackGound.graphics.clear();
         }
         _blackGound = null;
         super.dispose();
      }
   }
}

