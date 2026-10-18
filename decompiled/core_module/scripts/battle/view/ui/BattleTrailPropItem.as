package battle.view.ui
{
   import battle.events.BattleEvent;
   import com.pickgliss.ui.ComponentFactory;
   import flash.events.KeyboardEvent;
   import map.campaign.data.TrailPropInfo;
   import yishi.utils.IconFactory;
   import yishi.view.tools.SimpleMovie;
   
   public class BattleTrailPropItem extends BattleSkillItemII
   {
      
      private var _effect:SimpleMovie;
      
      public function BattleTrailPropItem()
      {
         super();
      }
      
      override protected function createAsset() : void
      {
         _icon = ComponentFactory.Instance.creatCustomObject("battle.TrailPropIcon");
         _iconContain = ComponentFactory.Instance.creatCustomObject("asset.battle.SkillItemCDFlashAsset");
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("battle.TrailPropCount");
         _downMc = ComponentFactory.Instance.creatCustomObject("asset.battle.DownMc");
         _overMc = ComponentFactory.Instance.creatCustomObject("asset.battle.OverMc");
         _ceNumView = new SkillItemCDNumView(44,0.6);
         _iconContain.x = 3;
         _iconContain.y = 1;
         _downMc.x = 4;
         _downMc.y = 5;
         _downMc.width = _downMc.height = 34;
         _overMc.width = _overMc.height = 35;
         _overMc.x = 9;
         _overMc.y = 7;
      }
      
      override public function set data(param1:Object) : void
      {
         _data = param1;
         if(_data)
         {
            _icon.tipData = (_data as TrailPropInfo).skillTemp;
            _data.addEventListener("TRAIL_USECOUNT_CHANGE",__countChangeHandler);
            _icon.icon = IconFactory.getTecIconByIcon((_data as TrailPropInfo).skillTemp.Icons);
            _countTxt.text = _data.useCount.toString();
         }
      }
      
      override public function cdStart(param1:int = 0, param2:int = -1) : void
      {
         if(_iconRemoved)
         {
            return;
         }
         if(_cdEffect)
         {
            _cdEffect.dispose();
         }
         if((_data as TrailPropInfo).skillTemp.CoolDown <= 0)
         {
            return;
         }
         if((_data as TrailPropInfo).coolDown == 0)
         {
            return;
         }
         _cdEffect = new SkillItemCDEffect((_data as TrailPropInfo).skillTemp.CoolDown,cdCompleteHandler,updateCDNum,30);
         _cdEffect.visible = false;
         _cdEffect.x = 6;
         _cdEffect.y = 6;
         _iconContain.container.addChild(_cdEffect);
         if(_cdEffect)
         {
            _cdEffect.start(param1,param2);
            _cdEffect.visible = true;
            showCDNum();
         }
      }
      
      override protected function cdCompleteHandler() : void
      {
         super.cdCompleteHandler();
         __countChangeHandler(null);
      }
      
      private function __countChangeHandler(param1:BattleEvent) : void
      {
         if(param1 && param1.data)
         {
            _effect = new SimpleMovie(ComponentFactory.Instance.creat("asset.battle.GetTraiCountMc"));
            _effect.x = 12;
            _effect.y = 12;
            addChild(_effect);
            _iconContain.gotoAndPlay(2);
         }
         _countTxt.text = _data.useCount.toString();
         if(!parentEnable)
         {
            return;
         }
         buttonSkiner.enable = _data.useCount > 0;
         if(buttonSkiner.enable)
         {
            setState(0);
         }
         else
         {
            setState(1);
         }
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         _data.removeEventListener("TRAIL_USECOUNT_CHANGE",__countChangeHandler);
      }
      
      override protected function onKeyDown(param1:KeyboardEvent) : void
      {
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         _data = null;
      }
   }
}

